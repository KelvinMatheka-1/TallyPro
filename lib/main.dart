import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await SupaFlow.initialize();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.path;
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = tallyProSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TallyPro',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF02CA79),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF02CA79),
          secondary: Color(0xFFFFD939),
        ),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF02CA79),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF02CA79),
          secondary: Color(0xFFFFD939),
        ),
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'AgentDash';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'AgentDash': AgentDashWidget(),
      'BackResultsTallyPage': BackResultsTallyPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    final validIndex = currentIndex >= 0 ? currentIndex : 0;
    final theme = FlutterFlowTheme.of(context);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 68.0,
          margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(34.0),
            border: Border.all(
              color: theme.alternate,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20.0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                index: 0,
                isActive: validIndex == 0,
                activeIcon: Icons.space_dashboard_rounded,
                inactiveIcon: Icons.space_dashboard_outlined,
                label: 'Dashboard',
                theme: theme,
                onTap: () => safeSetState(() {
                  _currentPage = null;
                  _currentPageName = 'AgentDash';
                }),
              ),
              _buildNavItem(
                index: 1,
                isActive: validIndex == 1,
                activeIcon: Icons.assessment_rounded,
                inactiveIcon: Icons.assessment_outlined,
                label: 'Results Tally',
                theme: theme,
                onTap: () => safeSetState(() {
                  _currentPage = null;
                  _currentPageName = 'BackResultsTallyPage';
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required bool isActive,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
    required FlutterFlowTheme theme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isActive ? theme.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? theme.primary : theme.secondaryText,
              size: 22.0,
            ),
            if (isActive) ...[
              const SizedBox(width: 8.0),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: theme.primary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AdminNavBarPage extends StatefulWidget {
  AdminNavBarPage({
    super.key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  });

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _AdminNavBarPageState createState() => _AdminNavBarPageState();
}

class _AdminNavBarPageState extends State<AdminNavBarPage> {
  String _currentPageName = 'LogoPollmasterWarPage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'LogoPollmasterWarPage': LogoPollmasterWarPageWidget(),
      'DisbursementmanagerpageColumnScrollablePage':
          DisbursementmanagerpageColumnScrollablePageWidget(),
      'BackToWarPage': BackToWarPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    final validIndex = currentIndex >= 0 ? currentIndex : 0;
    final theme = FlutterFlowTheme.of(context);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: MediaQuery(
        data: queryData
            .removeViewInsets(removeBottom: true)
            .removeViewPadding(removeBottom: true),
        child: _currentPage ?? tabs[_currentPageName]!,
      ),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 68.0,
          margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(34.0),
            border: Border.all(
              color: theme.alternate,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20.0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAdminNavItem(
                index: 0,
                isActive: validIndex == 0,
                activeIcon: Icons.space_dashboard_rounded,
                inactiveIcon: Icons.space_dashboard_outlined,
                label: 'Dashboard',
                theme: theme,
                onTap: () => safeSetState(() {
                  _currentPage = null;
                  _currentPageName = 'LogoPollmasterWarPage';
                }),
              ),
              _buildAdminNavItem(
                index: 1,
                isActive: validIndex == 1,
                activeIcon: Icons.payments_rounded,
                inactiveIcon: Icons.payments_outlined,
                label: 'Payouts',
                theme: theme,
                onTap: () => safeSetState(() {
                  _currentPage = null;
                  _currentPageName = 'DisbursementmanagerpageColumnScrollablePage';
                }),
              ),
              _buildAdminNavItem(
                index: 2,
                isActive: validIndex == 2,
                activeIcon: Icons.mark_email_read_rounded,
                inactiveIcon: Icons.mark_email_read_outlined,
                label: 'SMS Blast',
                theme: theme,
                onTap: () => safeSetState(() {
                  _currentPage = null;
                  _currentPageName = 'BackToWarPage';
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminNavItem({
    required int index,
    required bool isActive,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
    required FlutterFlowTheme theme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isActive ? theme.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? theme.primary : theme.secondaryText,
              size: 21.0,
            ),
            if (isActive) ...[
              const SizedBox(width: 6.0),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: theme.primary,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
