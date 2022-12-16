import 'package:flutter/material.dart';

import '../models/menu_option_model.dart';
import '../screens/screens.dart';

class AppRoute {
  static const initialRoute = 'logInScreen';

  static final menuOption = <MenuOption>[
    MenuOption(route: 'homeScreen', name: 'home', screen: const HomeScreen()),
    MenuOption(route: 'listScreen', name: 'home', screen: const ListScreen()),
    
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
   
        appRoutes.addAll(
        {'homeScreen': (BuildContext context) => const HomeScreen()});

        appRoutes.addAll(
        {'logInScreen': (BuildContext context) => const LoginScreen()});
         appRoutes.addAll(
        {'signInScreen': (BuildContext context) => const SignInScreen()});

        appRoutes.addAll(
        {'navigationScreen': (BuildContext context) => const NavigationScreen()});

        appRoutes.addAll(
        {'listScreen': (BuildContext context) => const ListScreen()});

        appRoutes.addAll(
        {'projectDetailScreen': (BuildContext context) => const ProjectDetailScreen()});
       
   
   

    return appRoutes;
  }
}