import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  enterUser({required String email, required String password}) {
    print('Entrar Usuario');
  }

  Future<String?> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(name);

      print('Funcionou Cadastro');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O e-mail já esta em uso.";
      }
      return e.code;
    }
    return null;
  }
}
