
import 'package:amir/screen/admin/screen/gestion%20cours/domaines/Create_domaine.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/menu_cours_screen.dart';
import 'package:amir/screen/admin/screen/gestion%20quiz/create_quiz.dart';
import 'package:amir/screen/enseigne/home_enseigne_screen.dart';
import 'package:amir/screen/navigation_screen.dart';
import 'package:amir/screen/profile_screen.dart';
import 'package:amir/screen/test.dart';
import 'package:flutter/material.dart';

import '../../screen/Authentication/Forgot_password/forgotpass.dart';
import '../../screen/Authentication/Sign_in/sign_in.dart';

import '../../screen/admin/screen/gestion_screen.dart';
import '../../screen/admin/screen/home_admin_screen.dart';
import '../../screen/admin/screen/read_account.dart';
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
      case '/adminhome':
        return MaterialPageRoute(builder: (_) => HomeAdmin());
      case '/enseignehome':
        return MaterialPageRoute(builder: (_) => HomeEnseigne());
        case '/gestioncompte':
        return MaterialPageRoute(builder: (_) => ReadAccount());
        case '/test':
        return MaterialPageRoute(builder: (_) => Test());
        case '/menucours':
        return MaterialPageRoute(builder: (_) => MenuCours());
        case '/createdomaines':
        return MaterialPageRoute(builder: (_) => CreateDomaines());
         case '/gestionadmin':
        return MaterialPageRoute(builder: (_) => GestionAdmin());
        case '/createquiz':
        return MaterialPageRoute(builder: (_) => CreateQuiz());

        
        
        

        

        

        

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
