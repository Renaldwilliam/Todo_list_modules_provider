import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exceptions.dart';

import './user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> registerUser(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthExceptions(
              message: "E-mail já utilizado, por favor escolha outro e-mail");
        } else {
          throw AuthExceptions(
              message:
                  "Você se cadastrou no TodoList pelo Google, por favor ultilize ele para entrar!!");
        }
      } else {
        throw AuthExceptions(
            message: e.message ?? "Erro ao resgistrar usuario");
      }
    }
  }
}
