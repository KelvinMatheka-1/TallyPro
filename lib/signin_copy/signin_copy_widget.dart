import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signin_copy_model.dart';
export 'signin_copy_model.dart';

class SigninCopyWidget extends StatefulWidget {
  const SigninCopyWidget({super.key});

  static String routeName = 'SigninCopy';
  static String routePath = '/signinCopy';

  @override
  State<SigninCopyWidget> createState() => _SigninCopyWidgetState();
}

class _SigninCopyWidgetState extends State<SigninCopyWidget> {
  late SigninCopyModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SigninCopyModel());

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _model.emailAddressTextController?.text.trim() ?? '';
    final password = _model.passwordTextController?.text ?? '';

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter both email and password.',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      GoRouter.of(context).prepareAuthEvent();

      final user = await authManager.signInWithEmail(
        context,
        email,
        password,
      );

      if (user == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      _model.currentUserProfille = await ProfilesTable().queryRows(
        queryFn: (q) => q.eqOrNull('id', currentUserUid),
      );

      final role = _model.currentUserProfille?.firstOrNull?.role;

      if (!mounted) return;

      if (role == 'admin') {
        context.pushNamedAuth(
          LogoPollmasterWarPageWidget.routeName,
          context.mounted,
        );
      } else {
        context.pushNamedAuth(
          AgentDashWidget.routeName,
          context.mounted,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign in failed: $e',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            // Theme Mode Switcher
            IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                color: theme.primaryText,
                size: 20.0,
              ),
              tooltip: Theme.of(context).brightness == Brightness.dark
                  ? 'Switch to Light Mode'
                  : 'Switch to Dark Mode',
              onPressed: () {
                final isDark =
                    Theme.of(context).brightness == Brightness.dark;
                MyApp.of(context).setThemeMode(
                    isDark ? ThemeMode.light : ThemeMode.dark);
              },
            ),
            const SizedBox(width: 12.0),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Brand Header
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 44.0,
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Icons.how_to_vote_rounded,
                            color: theme.primaryBackground,
                            size: 26.0,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tally',
                                style: GoogleFonts.readexPro(
                                  color: theme.primaryText,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Pro',
                                style: GoogleFonts.readexPro(
                                  color: theme.primary,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28.0),

                  // Login Card
                  Container(
                    padding: const EdgeInsets.all(28.0),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: theme.alternate,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Election Portal Sign In',
                          style: GoogleFonts.readexPro(
                            color: theme.primaryText,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          'Enter your agent or admin credentials to continue.',
                          style: GoogleFonts.inter(
                            color: theme.secondaryText,
                            fontSize: 13.0,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24.0),

                        // Email Field
                        Text(
                          'Email Address',
                          style: GoogleFonts.inter(
                            color: theme.primaryText,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        TextFormField(
                          controller: _model.emailAddressTextController,
                          focusNode: _model.emailAddressFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          style: GoogleFonts.inter(
                            color: theme.primaryText,
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'name@organization.com',
                            hintStyle: GoogleFonts.inter(
                              color: theme.secondaryText,
                              fontSize: 13.0,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: theme.secondaryText,
                              size: 18.0,
                            ),
                            filled: true,
                            fillColor: theme.primaryBackground,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.alternate,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.primary,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 12.0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16.0),

                        // Password Field
                        Text(
                          'Password',
                          style: GoogleFonts.inter(
                            color: theme.primaryText,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        TextFormField(
                          controller: _model.passwordTextController,
                          focusNode: _model.passwordFocusNode,
                          obscureText: !_model.passwordVisibility,
                          autofillHints: const [AutofillHints.password],
                          onFieldSubmitted: (_) => _handleSignIn(),
                          style: GoogleFonts.inter(
                            color: theme.primaryText,
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter your password',
                            hintStyle: GoogleFonts.inter(
                              color: theme.secondaryText,
                              fontSize: 13.0,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: theme.secondaryText,
                              size: 18.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _model.passwordVisibility
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: theme.secondaryText,
                                size: 18.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _model.passwordVisibility =
                                      !_model.passwordVisibility;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: theme.primaryBackground,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.alternate,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.primary,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 12.0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24.0),

                        // Submit Sign In Button
                        SizedBox(
                          height: 44.0,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primary,
                              disabledBackgroundColor:
                                  theme.primary.withValues(alpha: 0.6),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 18.0,
                                    height: 18.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Sign In to Dashboard',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  // Bottom Security Note
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: theme.secondaryText,
                        size: 14.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Secure Election Audit & Tally Verification',
                        style: GoogleFonts.inter(
                          color: theme.secondaryText,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
