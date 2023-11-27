import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  enterUser({required String email, required String password}) {
    print('Entrar Usuario');
  }

  registerUser(
      {required String email,
      required String password,
      required String name}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    await userCredential.user!.updateDisplayName(name);
    
    print('Funcionou Cadastro');
  }
}
