import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/routes/app_route_names.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child:  Column(
        children: [
          ListItem(imagePath: ImageRes.settings, text: "Settings",
          onTap: () {
            Navigator.of(context).pushNamed(AppRouteNames.settings);
          },),
          const SizedBox(height: 15,),
          const ListItem(imagePath: ImageRes.creditCard, text: "Payment Details"),
          const SizedBox(height: 15,),
          const ListItem(imagePath: ImageRes.award, text: "Achievements"),
          const SizedBox(height: 15,),
          const ListItem(imagePath: ImageRes.love, text: "Favorite Courses"),
          const SizedBox(height: 15,),
          const ListItem(imagePath: ImageRes.reminder, text: "Reminder"),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? onTap;
  const ListItem({
    super.key,
    required this.imagePath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(7.w),
            // margin: EdgeInsets.only(bottom: 15.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryElement),
            ),
            child: AppImage(imagePath: imagePath),
          ),
          SizedBox(width: 15.w),
          Text13Normal(text: text),
        ],
      ),
    );
  }
}
