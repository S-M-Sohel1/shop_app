import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/routes/app_route_names.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class ProfileCourses extends StatelessWidget {
  const ProfileCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ProfileLink(
            imagePath: ImageRes.profileVideo,
            text: "My Courses",
          ),
          ProfileLink(
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(AppRouteNames.coursesBought);
            },
            imagePath: ImageRes.profileBook,
            text: "Courses Bought",
          ),
          const ProfileLink(
            imagePath: ImageRes.profileStar,
            text: "4.6",
          ),
        ],
      ),
    );
  }
}

class ProfileLink extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? onTap;
  const ProfileLink({
    super.key,
    required this.imagePath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.primaryElement,
          border: Border.all(color: AppColors.primaryElement),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(height: 20.h, width: 20.w, imagePath: imagePath),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text11Normal(
                text: text,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
