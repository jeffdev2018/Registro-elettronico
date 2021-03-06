import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_elettronico/component/navigator.dart';
import 'package:registro_elettronico/main.dart';
import 'package:registro_elettronico/ui/bloc/auth/bloc.dart';
import 'package:registro_elettronico/ui/global/localizations/app_localizations.dart';
import 'package:registro_elettronico/utils/constants/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _alreadyInit = false;

  @override
  void didChangeDependencies() async {
    // Workmanager.initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true,
    // );

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences
    //     .getBool(PrefsConstants.GRADES_NOTIFICATIONS ?? "false13"));

    ///Workmanager.registerOneOffTask(
    ///  "checkForNewContent",
    ///  "checkForNewContent",
    ///  initialDelay: Duration(seconds: 2),
    ///);

    super.didChangeDependencies();
    if (!_alreadyInit) {
      _alreadyInit = true;
      _autoSignIn(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          /// Checks if the autosign in returns the positive result that the user is
          /// auto signed in, so it redirects to the Home page
          if (state is AutoSignInResult) {
            AppNavigator.instance.navToHome(context);
          }

          /// If the auto sign in returns an error the user is redirected to the
          /// login page
          if (state is AutoSignInError) {
            AppNavigator.instance.navToLogin(context);
          }
        },
        child: Center(
          child: Icon(
            Icons.school,
            color: Theme.of(context).accentColor,
            size: 64.0,
          ),
        ),
      ),
    );
  }

  void _autoSignIn(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AutoSignIn());
  }
}
