import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
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
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
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

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        selectedItemColor: Color(0xFF60CBEE),
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        selectedBackgroundColor: Color(0x00000000),
        borderRadius: 8.0,
        itemBorderRadius: 8.0,
        margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        width: double.infinity,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: currentIndex == 0
                      ? Color(0xFF60CBEE)
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: currentIndex == 0 ? 24.0 : 26.0,
                ),
                Text(
                  'Home',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 0
                        ? Color(0xFF60CBEE)
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.move_to_inbox,
                  color: currentIndex == 1
                      ? Color(0xFF60CBEE)
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 26.0,
                ),
                Text(
                  'results',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 1
                        ? Color(0xFF60CBEE)
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          )
        ],
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
      bottomNavigationBar: FloatingNavbar(
        currentIndex: validIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        selectedBackgroundColor: const Color(0x00000000),
        borderRadius: 8.0,
        itemBorderRadius: 8.0,
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        width: double.infinity,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  validIndex == 0
                      ? Icons.dashboard_rounded
                      : Icons.dashboard_outlined,
                  color: validIndex == 0
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                Text(
                  'Dashboard',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: validIndex == 0
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                    fontWeight:
                        validIndex == 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  validIndex == 1
                      ? Icons.payments_rounded
                      : Icons.payments_outlined,
                  color: validIndex == 1
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                Text(
                  'Payouts',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: validIndex == 1
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                    fontWeight:
                        validIndex == 1 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  validIndex == 2
                      ? Icons.mark_email_read_rounded
                      : Icons.mark_email_read_outlined,
                  color: validIndex == 2
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                Text(
                  'SMS Blast',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: validIndex == 2
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                    fontWeight:
                        validIndex == 2 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
