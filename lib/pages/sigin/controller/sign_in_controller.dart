import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/commons/models/entities.dart';
import 'package:learning_app/commons/global_loader/global_loader.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/widgets/popup_messages.dart';
import 'package:learning_app/global.dart';
import 'package:learning_app/main.dart';
import 'package:learning_app/pages/sigin/provider/sign_in_notifier.dart';
import 'package:learning_app/pages/sigin/repo/sign_in_repo.dart';

class SignInController {
  SignInController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Future<void> handleSignIn(ref) async {
    var state = ref.read(signInNotifierProvider);

    String email = state.email ?? "";
    String password = state.password;

    emailController.text = email;
    passController.text = password;
    print('email: $email');
    print('pass: $password');

    if (email.isEmpty || state.email.isEmpty) {
      toastInfo("Your email is empty");
      return;
    }
    if (state.password.isEmpty) {
      toastInfo("Your password is empty");
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    // print('1');
    try {
      final credential = await SignInRepo.firebaseSignIn(
        email,
        password,
      );
      // print("after credin");
      var user = credential.user;
      if (user == null) {
        toastInfo('User not found');
      }
      if (!user!.emailVerified) {
        toastInfo('Verify your email first');
      }
      String? displayName = user.displayName;
      String? userEmail = user.email; // Renamed to avoid shadowing
      String? id = user.uid;
      String? photoUrl = user.photoURL;

      LoginRequestEntity loginRequestEntity = LoginRequestEntity();
      loginRequestEntity.avatar = photoUrl;
      loginRequestEntity.name = displayName;
      loginRequestEntity.email = userEmail ; // Provide fallback
      loginRequestEntity.open_id = id;
      loginRequestEntity.type = 1;
      print("avatar: ${loginRequestEntity.avatar}");
      print("openid: ${loginRequestEntity.open_id}");

      asyncPostAllData(loginRequestEntity);
      toastInfo('User logged in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastInfo("User doesn't exist");
      } else if (e.code == 'wrong password') {
        toastInfo('Your password is wrong');
      }
      // print(e.message);
      toastInfo(e.message.toString());
    } catch (e) {
      print(e.toString());
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  Future<void> asyncPostAllData(
    LoginRequestEntity loginRequestEntity,
  ) async {
    // talk to server
    var result = await SignInRepo.login(params: loginRequestEntity);
    print("HAHAH");
    //local storage
    // print("After result");
    if (result.code == 200) {
      try {
         Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY,
          jsonEncode(result.data),
        );
        Global.storageService.setString(
          AppConstants.STORAGE_USER_TOKEN_KEY,
          result.data!.access_token!,
        );

        navKey.currentState?.pushNamedAndRemoveUntil(
          '/application',
          (route) => false,
        );
        
      } catch (e) {
        print(e.toString());
      }
    }else{
      toastInfo("Login error");
    }

    //redirect to new page
  }
}
