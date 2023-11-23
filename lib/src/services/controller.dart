import 'package:get/get.dart';
import 'package:listapratica/src/home/db_helper.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;

  Future<void> setUser(String name, String email) async {
    DBHelper dbHelper = DBHelper();
    User user = User(name: name, email: email);

    if (userName.value.isEmpty) {
      await dbHelper.insertUser(user);
    } else {
      await dbHelper.updateUser(user);
    }

    userName.value = name;
    userEmail.value = email;
  }

  Future<void> loadUser() async {
    DBHelper dbHelper = DBHelper();
    User? user = await dbHelper.getUser();

    if (user != null) {
      userName.value = user.name;
      userEmail.value = user.email;
    }
  }
}
