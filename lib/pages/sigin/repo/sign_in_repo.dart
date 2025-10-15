import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_app/commons/models/entities.dart';
import 'package:learning_app/commons/services/http_util.dart';

class SignInRepo {
  static Future<UserCredential> firebaseSignIn(
    String email,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  static Future<UserLoginResponseEntity> login({
    LoginRequestEntity? params,
  }) async {
    // print("data: ${params!.toJson()}");
    var response = await HttpUtil().post(
      'api/login',
      queryParameters: params!.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response);
  }
}
