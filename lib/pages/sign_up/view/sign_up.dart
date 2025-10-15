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
import 'package:learning_app/pages/sign_up/provider/register_notifier.dart';
import 'package:learning_app/pages/sign_up/controller/sign_up_controller.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;
  @override
  void initState() {
    _controller = SignUpController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);
    final loader = ref.watch(appLoaderProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppbar(title: "Sign Up"),
          backgroundColor: Colors.white,
          body:
              loader == false
                  ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        const Center(
                          child: Text14Normal(
                            text: 'Enter your details below and free signup',
                          ),
                        ),
                        SizedBox(height: 50.h),
                        //username
                        AppTextField(
                          text: "Username",
                          iconName: ImageRes.user,
                          hintText: "Enter your user name",
                          func: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onUserNameChange(value);
                          },
                        ),
                        SizedBox(height: 20.h),
                        //email text box
                        AppTextField(
                          text: "Email",
                          iconName: ImageRes.user,
                          hintText: "Enter your email address",
                          func: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onUserEmailChange(value);
                          },
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          text: "Password",
                          iconName: ImageRes.lock,
                          hintText: "Enter your password",
                          obscureText: true,
                          func: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onUserPasswordChange(value);
                          },
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          text: "Confirm Password",
                          iconName: ImageRes.lock,
                          hintText: "Confirm your password",
                          obscureText: true,
                          func: (value) {
                            ref
                                .read(registerNotifierProvider.notifier)
                                .onUserRePasswordChange(value);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25.w),
                          child:const Text14Normal(
                            text:
                                "By creating an account, you are agreeing with our terms and conditions",
                          ),
                        ),

                        SizedBox(height: 100.h),
                        Center(
                          child: AppButton(
                            buttonName: "Register",
                            isLogin: true,
                            context: context,
                            func: () {
                              _controller.handleSignUp();
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
