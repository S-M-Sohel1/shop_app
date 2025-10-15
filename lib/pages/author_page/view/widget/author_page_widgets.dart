
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/courses_tile.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class AuthorMenu extends StatelessWidget {
  final AuthorItem authorItem;
  const AuthorMenu({super.key, required this.authorItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 220.h,
      child: Stack(
        children: [
          Container(
            width: 350.w,
            height: 160.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              image: const DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(ImageRes.background),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 350.w,
              margin: EdgeInsets.only(left: 20.h),
              child: Row(
                children: [
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.w),
                      image: DecorationImage(
                        image: NetworkImage(
                          "${AppConstants.SERVER_API_URL}${authorItem.avatar}",
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 6.w, top: 10.h),
                        child: Text13Normal(
                          text: authorItem.name ?? "",
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 6.w),
                        child: Text12Normal(
                          color: AppColors.primarySecondaryElementText,
                          text: authorItem.job ?? "A Freelancer",
                        ),
                      ),
                      SizedBox(height: 5.h),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AuthorTextAndIcon(
                            text: "69",
                            icon: ImageRes.people,
                            first: true,
                          ),
                          AuthorTextAndIcon(
                            text: "69",
                            icon: ImageRes.star,
                            first: false,
                          ),
                          AuthorTextAndIcon(
                            text: "17",
                            icon: ImageRes.downloadDetail,
                            first: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorTextAndIcon extends StatelessWidget {
  const AuthorTextAndIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.first,
  });

  final String text;
  final String icon;
  final bool first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: first == true ? 3.w : 20.w),
      child: Row(
        children: [
          AppImage(imagePath: icon),
          Text12Normal(text: text, color: AppColors.primaryThreeElementText),
        ],
      ),
    );
  }
}

class AuthorDescription extends StatelessWidget {
  final AuthorItem authorItem;
  const AuthorDescription({super.key, required this.authorItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text16Normal(
            text: "About me",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Text12Normal(
              text: authorItem.description ?? "",
              color: AppColors.primaryThreeElementText,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorAllCourses extends StatelessWidget {
  final List<CourseItem> value;
  const AuthorAllCourses({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: [
          Container(
            width: double.infinity,
            height: 40.h,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30.w),
            margin: EdgeInsets.only(top: 20.h,),
            child: const Text14Normal(
              text: "Author's All Courses",
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 360.w,
            height: 400.h,
            child: CoursesTile(value: value)),
        ],
      ),
    );
  }
}