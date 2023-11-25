import 'package:flutter/material.dart';
import 'package:listapratica/src/screens/configuration/configuration_page.dart';
import 'package:listapratica/src/screens/home/home_page.dart';
import 'package:listapratica/src/screens/initial/initial_page.dart';
import 'package:listapratica/src/shared/themes/themes.dart';
import 'package:listapratica/src/screens/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  AppWidgetState createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> {
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      themeMode: _selectedTheme,
      theme: darkTheme,
      routes: {
        '/': (context) => const SplashPage(),
        '/initial': (context) => const InitialPage(),
        '/home': (context) => const HomePage(),
        '/config': (context) => ConfigurationPage(
          onThemeChanged: (themeMode) {
            setState(() {
              _selectedTheme = themeMode;
            });
          },
        ),
        
      },
    );
  }
}
