import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listapratica/src/home/db_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkUser().then((userExists) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
        if (userExists) {
          Navigator.of(context).pushNamed('/home');
        } else {
          Navigator.of(context).pushNamed('/initial');
        }
      });
    });
  }

  Future<bool> _checkUser() async {
    DBHelper dbHelper = DBHelper();
    User? user = await dbHelper.getUser();
    return user != null && user.name.isNotEmpty && user.email.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ListaPrática',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            CupertinoActivityIndicator(
              color: Colors.white,
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
