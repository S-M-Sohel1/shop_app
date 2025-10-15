import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final String iconName;
  final String hintText;
  final bool obscureText;
  final void Function(String value)? func;
  const AppTextField({
    super.key,
    this.controller,
    this.text = "",
    this.iconName = "",
    this.hintText = "Type your info",
    this.obscureText = false,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.w, right: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text14Normal(text: text),
          SizedBox(height: 5.h),
          Container(
            width: 325.w,
            height: 50.h,
            // color: Colors.red,
            decoration: appBoxDecorationField(),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  child: AppImage(imagePath: iconName),
                ),
                AppTextFieldOnly(
                  controller: controller,
                  hintText: hintText,
                  func: func,
                  obscureText: obscureText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppTextFieldOnly extends StatelessWidget {
  final String hintText;
  final double width;
  final double height;
  final TextEditingController? controller;
  final void Function(String value)? func;
  final bool obscureText;
  final bool? search;

  const AppTextFieldOnly({
    super.key,
    this.hintText = "",
    this.width = 200,
    this.height = 50,
    this.controller,
    this.func,
    this.obscureText = false,
    this.search = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextField(
        controller: controller,
        onChanged:
            search == false
                ? (value) {
                  func!(value);
                }
                : null,
        onSubmitted:
            search == true
                ? (value) {
                  func!(value);
                }
                : null,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7.h, left: 10.w),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          //enabled, without input
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),

        maxLines: 1,
        autocorrect: false,
        obscureText: obscureText,
      ),
    );
  }
}
