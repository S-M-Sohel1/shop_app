import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/global.dart';

Widget appOnBoardingPage(
  PageController controller, {
  String imagePath = 'assets/images/reading.png',
  String title = '',
  String subTitle = '',
  int index = 0,
  required BuildContext context,
}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Image.asset(imagePath,
        height: 400.sp,
        
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16.h),
              child: text24Normal(text: title),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 28.w, right: 28.w),
              child: Text16Normal(text: subTitle),
            ),
            _nextButton(index, controller, context),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              child: DotsIndicator(
                dotsCount: 3,
                mainAxisAlignment: MainAxisAlignment.center,
                position: (index - 1).toDouble(),
                decorator: DotsDecorator(
                  size:  Size.square(9.r),
                  activeSize:  Size(36.w, 8.h),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index < 3) {
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      } else {
        Global.storageService.setBool(
          AppConstants.STORAGE_DEVICE_OPEN_FIRST_KEY,
          true,
        );
        Navigator.pushNamed(context, '/signIn');
      }
    },
    child: Container(
      width: 361.w,
      height: 50.sp,
      margin: EdgeInsets.only(top: 50.h, left: 24.w, right: 24.w),
      decoration: appBoxShadow(),
      child: Center(
        child: Text16Normal(
          text: index == 3 ? 'Get Started' : 'next',
          color: AppColors.primaryBackground,
        ),
      ),
    ),
  );
}
