

import 'package:flutter/material.dart';
import 'package:prueba/services/project_service.dart';
import 'package:prueba/theme/app_theme.dart';
import 'providers/providers.dart';
import 'routes/app_route.dart';
import 'services/services.dart';

void main() async {

  runApp(const AppState());

}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProjectListProvider()),
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => UiProvider()),
      ChangeNotifierProvider(
        create: (_) => ProjectService(), lazy: false,
      ),


    ], child: const MyApp() ,);
  }
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoute.initialRoute,
      routes: AppRoute.getAppRoutes(),
      theme: AppTheme.lightTheme,
      

    );
  }
}