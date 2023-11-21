import 'package:flutter/material.dart';
import 'package:listapratica/screens/src/configuration/configuration_page.dart';
import 'package:listapratica/screens/src/home/home_page.dart';
import 'package:listapratica/screens/src/shared/themes/themes.dart';

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
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: {
        '/': (context) => const HomePage(),
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
