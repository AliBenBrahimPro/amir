
import 'package:amir/screen/admin/screen/gestion%20cours/domaines/Create_domaine.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/menu_cours_screen.dart';
import 'package:amir/screen/admin/screen/gestion%20quiz/create_quiz.dart';
import 'package:amir/screen/chapitreAndLecon.dart';
import 'package:amir/screen/enseigne/screen/home_screen.dart';
import 'package:amir/screen/navigation_screen.dart';
import 'package:amir/screen/pdf_reader.dart';
import 'package:amir/screen/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../screen/Authentication/Forgot_password/forgotpass.dart';
import '../../screen/Authentication/Sign_in/sign_in.dart';

import '../../screen/Tabar_screen.dart';
import '../../screen/admin/screen/gestion quiz/form_quiz.dart';
import '../../screen/admin/screen/gestion quiz/read_quiz.dart';
import '../../screen/admin/screen/gestion quiz/select_cour.dart';
import '../../screen/admin/screen/gestion_screen.dart';
import '../../screen/admin/screen/home_admin_screen.dart';
import '../../screen/admin/screen/read_account.dart';
import '../../screen/pdfAndVideo.dart';
import '../../screen/splash_screen/splash_screen.dart';
import '../../widgets/qustion_widget.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/reset_password':
        return MaterialPageRoute(builder: (_) => ForgotPassScreen());
   
        case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/adminhome':
        return MaterialPageRoute(builder: (_) => HomeAdmin());
      // case '/enseignehome':
      //   return MaterialPageRoute(builder: (_) => HomeChat());
        case '/gestioncompte':
        return MaterialPageRoute(builder: (_) => ReadAccount());
        
        case '/menucours':
        return MaterialPageRoute(builder: (_) => MenuCours());
        case '/createdomaines':
        return MaterialPageRoute(builder: (_) => CreateDomaines());
         case '/gestionadmin':
        return MaterialPageRoute(builder: (_) => GestionAdmin());
        case '/createquiz':
        return MaterialPageRoute(builder: (_) => QuestionForm());
        case '/selectcour':
        return MaterialPageRoute(builder: (_) => SelectCours());

        
        
        

        

        

        

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
