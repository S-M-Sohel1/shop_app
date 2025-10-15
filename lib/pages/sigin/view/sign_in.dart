import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/global_loader/global_loader.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/app_bar.dart';
import 'package:learning_app/commons/widgets/app_textfield.dart';
import 'package:learning_app/commons/widgets/button_widgets.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/sigin/provider/sign_in_notifier.dart';
import 'package:learning_app/pages/sigin/controller/sign_in_controller.dart';
import 'package:learning_app/pages/sigin/view/widgets/sign_in_widgets.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late SignInController _controller;
  @override
  void didChangeDependencies() {
    _controller = SignInController();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = ref.watch(signInNotifierProvider);
    final loader = ref.watch(appLoaderProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppbar(title: "Login"),
          backgroundColor: Colors.white,
          body:
              loader == false
                  ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //login buttons
                        thirdPartyLogin(),

                        const Center(
                          child: Text14Normal(
                            text:
                                'Or use your email account to login',
                          ),
                        ),
                        SizedBox(height: 50.h),
                        //email text box
                        AppTextField(
                          controller: _controller.emailController,
                          text: "Email",
                          iconName: ImageRes.user,
                          hintText: "Enter your email address",
                          func: (value) {
                            ref
                                .read(signInNotifierProvider.notifier)
                                .onUserEmailChange(value);
                          },
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: _controller.passController,
                          text: "Password",
                          iconName: ImageRes.lock,
                          hintText: "Enter your password",
                          obscureText: true,
                          func: (value) {
                            ref
                                .read(signInNotifierProvider.notifier)
                                .onUserPasswordChange(value);
                          },
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.only(left: 25.w),
                          child: textUnderline("Forgot password?"),
                        ),
                        SizedBox(height: 100.h),
                        Center(
                          child: AppButton(
                            buttonName: "Login",
                            context: context,
                            func: () => _controller.handleSignIn(ref),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: AppButton(
                            buttonName: "Register",
                            isLogin: false,
                            context: context,
                            func: () {
                              Navigator.pushNamed(context, "/signUp");
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                  : const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      color: AppColors.primaryElement,
                    ),
                  ),
        ),
      ),
    );
  }
}
