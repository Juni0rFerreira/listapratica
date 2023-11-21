import 'package:flutter/material.dart';
import 'package:listapratica/src/configuration/configuration_page.dart';
import 'package:listapratica/src/home/home_page.dart';
import 'package:listapratica/src/profiler/profiler_page.dart';
import 'package:listapratica/src/shared/themes/themes.dart';
import 'package:listapratica/src/splash/splash_page.dart';

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
        '/home': (context) => const HomePage(),
        '/profiler': (context) => const ProfilerPage(),
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
