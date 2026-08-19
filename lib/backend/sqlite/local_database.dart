import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import '/backend/supabase/supabase.dart';

class LocalDatabase {
  LocalDatabase._();
  static final LocalDatabase instance = LocalDatabase._();

  sql.Database? _db;

  // In-memory fallback cache for Web or environments without native SQLite C-bindings
  final Map<String, Map<String, dynamic>> _webTalliesCache = {};
  final Map<String, Map<String, dynamic>> _webVotersCache = {};
  final List<Map<String, dynamic>> _webOfflineQueue = [];

  Future<sql.Database?> get database async {
    if (kIsWeb) return null;
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  Future<sql.Database> _initDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final path = p.join(dbPath, 'tallypro_offline.db');

    return await sql.openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE local_tallies (
            id TEXT PRIMARY KEY,
            stream_id TEXT NOT NULL,
            candidate_id TEXT NOT NULL,
            candidate_name TEXT,
            party TEXT,
            votes_count INTEGER NOT NULL,
            submitted_at TEXT NOT NULL,
            is_synced INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE local_voters (
            id TEXT PRIMARY KEY,
            stream_id TEXT,
            full_name TEXT NOT NULL,
            national_id TEXT NOT NULL,
            phone_number TEXT,
            has_voted INTEGER DEFAULT 0,
            checked_in_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE offline_queue (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            action_type TEXT NOT NULL,
            payload TEXT NOT NULL,
            created_at TEXT NOT NULL,
            attempts INTEGER DEFAULT 0,
            status TEXT DEFAULT 'PENDING'
          )
        ''');
      },
    );
  }

  // ==================== TALLIES OFFLINE OPERATIONS ====================

  Future<void> saveTallyOffline({
    required String streamId,
    required String candidateId,
    required int votesCount,
    String? candidateName,
    String? party,
  }) async {
    final tallyId = '${streamId}_$candidateId';
    final submittedAt = DateTime.now().toIso8601String();

    final data = {
      'id': tallyId,
      'stream_id': streamId,
      'candidate_id': candidateId,
      'candidate_name': candidateName ?? '',
      'party': party ?? '',
      'votes_count': votesCount,
      'submitted_at': submittedAt,
      'is_synced': 0,
    };

    if (kIsWeb) {
      _webTalliesCache[tallyId] = data;
      _webOfflineQueue.add({
        'id': _webOfflineQueue.length + 1,
        'action_type': 'UPSERT_TALLY',
        'payload': jsonEncode(data),
        'created_at': submittedAt,
        'status': 'PENDING',
      });
      return;
    }

    final db = await database;
    if (db != null) {
      await db.insert(
        'local_tallies',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );

      await db.insert(
        'offline_queue',
        {
          'action_type': 'UPSERT_TALLY',
          'payload': jsonEncode(data),
          'created_at': submittedAt,
          'attempts': 0,
          'status': 'PENDING',
        },
      );
    }
  }

  Future<List<Map<String, dynamic>>> getTalliesForStream(String streamId) async {
    if (kIsWeb) {
      return _webTalliesCache.values
          .where((t) => t['stream_id'] == streamId)
          .toList();
    }

    final db = await database;
    if (db == null) return [];

    return await db.query(
      'local_tallies',
      where: 'stream_id = ?',
      whereArgs: [streamId],
    );
  }

  // ==================== VOTERS OFFLINE OPERATIONS ====================

  Future<void> cacheVoters(List<Map<String, dynamic>> votersList) async {
    if (kIsWeb) {
      for (final v in votersList) {
        final id = v['id']?.toString() ?? v['national_id']?.toString() ?? '';
        if (id.isNotEmpty) {
          _webVotersCache[id] = v;
        }
      }
      return;
    }

    final db = await database;
    if (db == null) return;

    final batch = db.batch();
    for (final v in votersList) {
      batch.insert(
        'local_voters',
        {
          'id': v['id']?.toString() ?? v['national_id']?.toString() ?? '',
          'stream_id': v['stream_id']?.toString() ?? '',
          'full_name': v['full_name']?.toString() ?? '',
          'national_id': v['national_id']?.toString() ?? '',
          'phone_number': v['phone_number']?.toString() ?? '',
          'has_voted': (v['has_voted'] == true || v['has_voted'] == 1) ? 1 : 0,
          'checked_in_at': v['checked_in_at']?.toString(),
        },
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> searchVotersOffline(
    String query, {
    String? streamId,
  }) async {
    final cleanQuery = query.trim().toLowerCase();

    if (kIsWeb) {
      return _webVotersCache.values.where((v) {
        final fullName = (v['full_name'] ?? '').toString().toLowerCase();
        final nationalId = (v['national_id'] ?? '').toString().toLowerCase();
        final matchesQuery =
            fullName.contains(cleanQuery) || nationalId.contains(cleanQuery);
        final matchesStream =
            streamId == null || v['stream_id']?.toString() == streamId;
        return matchesQuery && matchesStream;
      }).toList();
    }

    final db = await database;
    if (db == null) return [];

    if (streamId != null && streamId.isNotEmpty) {
      return await db.rawQuery('''
        SELECT * FROM local_voters 
        WHERE stream_id = ? AND (LOWER(full_name) LIKE ? OR national_id LIKE ?)
        LIMIT 50
      ''', [streamId, '%$cleanQuery%', '%$cleanQuery%']);
    } else {
      return await db.rawQuery('''
        SELECT * FROM local_voters 
        WHERE LOWER(full_name) LIKE ? OR national_id LIKE ?
        LIMIT 50
      ''', ['%$cleanQuery%', '%$cleanQuery%']);
    }
  }

  // ==================== SYNC QUEUE OPERATIONS ====================

  Future<int> getUnsyncedCount() async {
    if (kIsWeb) {
      return _webOfflineQueue.where((item) => item['status'] == 'PENDING').length;
    }

    final db = await database;
    if (db == null) return 0;

    final countResult = await db.rawQuery(
      "SELECT COUNT(*) as count FROM offline_queue WHERE status = 'PENDING'",
    );
    return sql.Sqflite.firstIntValue(countResult) ?? 0;
  }

  Future<int> syncPendingQueue() async {
    final supabase = SupaFlow.client;
    int syncedCount = 0;

    if (kIsWeb) {
      for (final item in _webOfflineQueue) {
        if (item['status'] == 'PENDING') {
          try {
            final payload = jsonDecode(item['payload'] as String);
            if (item['action_type'] == 'UPSERT_TALLY') {
              await supabase.from('tallies').upsert(
                {
                  'stream_id': payload['stream_id'],
                  'candidate_id': payload['candidate_id'],
                  'agent_id': supabase.auth.currentUser?.id,
                  'votes_count': payload['votes_count'],
                  'submitted_at': payload['submitted_at'],
                },
                onConflict: 'stream_id,candidate_id',
              );
            }
            item['status'] = 'SYNCED';
            syncedCount++;
          } catch (e) {
            debugPrint('Offline sync error (web): \$e');
          }
        }
      }
      return syncedCount;
    }

    final db = await database;
    if (db == null) return 0;

    final pendingItems = await db.query(
      'offline_queue',
      where: "status = 'PENDING'",
      orderBy: 'id ASC',
      limit: 100,
    );

    for (final item in pendingItems) {
      try {
        final id = item['id'] as int;
        final actionType = item['action_type'] as String;
        final payload = jsonDecode(item['payload'] as String);

        if (actionType == 'UPSERT_TALLY') {
          await supabase.from('tallies').upsert(
            {
              'stream_id': payload['stream_id'],
              'candidate_id': payload['candidate_id'],
              'agent_id': supabase.auth.currentUser?.id,
              'votes_count': payload['votes_count'],
              'submitted_at': payload['submitted_at'],
            },
            onConflict: 'stream_id,candidate_id',
          );

          // Mark tally as synced in local SQLite table
          await db.update(
            'local_tallies',
            {'is_synced': 1},
            where: 'stream_id = ? AND candidate_id = ?',
            whereArgs: [payload['stream_id'], payload['candidate_id']],
          );
        }

        // Mark queue item as SYNCED
        await db.update(
          'offline_queue',
          {'status': 'SYNCED'},
          where: 'id = ?',
          whereArgs: [id],
        );
        syncedCount++;
      } catch (e) {
        debugPrint('Offline sync item failed: \$e');
        final id = item['id'] as int;
        final attempts = (item['attempts'] as int? ?? 0) + 1;
        await db.update(
          'offline_queue',
          {'attempts': attempts},
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }

    return syncedCount;
  }
}