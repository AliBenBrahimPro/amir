
import 'package:amir/screen/navigation_screen.dart';
import 'package:amir/screen/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../screen/Authentication/Forgot_password/forgotpass.dart';
import '../../screen/Authentication/Sign_in/sign_in.dart';
import '../../screen/splash_screen/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/reset_password':
        return MaterialPageRoute(builder: (_) => ForgotPassScreen());
      case '/homepage':
        return MaterialPageRoute(builder: (_) => NavigationScreen());
        case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
