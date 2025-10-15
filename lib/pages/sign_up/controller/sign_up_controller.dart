import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_app/commons/global_loader/global_loader.dart';
import 'package:learning_app/commons/widgets/popup_messages.dart';
import 'package:learning_app/pages/sign_up/provider/register_notifier.dart';
import 'package:learning_app/pages/sign_up/repo/sign_up_repo.dart';

class SignUpController {
  final WidgetRef ref;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotifierProvider);

    String name = state.userName;
    String email = state.email;

    String password = state.password;
    String rePassword = state.rePassword;

    // print("name: $name");
    // print("email: $email");
    // print("pass: $password");
    // print("rePass:$rePassword");
    if (name.isEmpty || state.userName.isEmpty) {
      toastInfo("Your name is empty");
      return;
    }
    if (name.length < 6 || state.userName.length < 6) {
      toastInfo("Your name is too short");
      return;
    }
    if (email.isEmpty || state.email.isEmpty) {
      toastInfo("Your email is empty");
      return;
    }
     if (state.password.isEmpty || state.rePassword.isEmpty) {
      toastInfo("Your password is empty");
      return;
    }

    if (state.password != state.rePassword) {
      toastInfo("Your password didn't match");
      return;
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    final ctx = Navigator.of(ref.context);
    
    try {
       
      final credential = await SignUpRepo.firebaseSignUp(email, password);
          // print('haha');
          if(kDebugMode){
            print(credential);

          }
          if(credential.user!=null){
            await credential.user?.sendEmailVerification();
            await credential.user?.updateDisplayName(name);
            String photoUrl='api/uploads/default.png';
            await credential.user?.updatePhotoURL(photoUrl);
            toastInfo("An email has been sent to verify your account. Please open the email and confirm your identity");
            ctx.pop();
          }

    } on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){
        toastInfo('Your password is too weak');
      }else if(e.code=='email-already-in-use'){
        toastInfo('This email is already registered');
      }else if(e.code=='user-not-found'){
        toastInfo('User not found');
      }
    }
     catch (e) {
     print(e.toString());
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(false);


  }
}
