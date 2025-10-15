import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/routes/app_route_names.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';

class CoursesTile extends StatelessWidget {
  final List<CourseItem> value;
  const CoursesTile({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final val in value)
          
            Container(
              width: 325.w,
              height: 80.h,
              margin: EdgeInsets.only(bottom: 15.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color.fromRGBO(255, 255, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: InkWell(
                onTap:
                    () => Navigator.of(context).pushNamed(
                      AppRouteNames.courseDetail,
                      arguments: {"id": val.id},
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60.r,
                          width: 60.r,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                "${AppConstants.IMAGE_UPLOAD_PATH}${val.thumbnail}",
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 6.w),
                              width: 180.w,
                              child: Text13Normal(
                                text: val.name.toString(),
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                maxLine: 1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 6.w),
                              width: 180.w,
                              child: Text10Normal(
                                text:
                                    "${val.lesson_num} Lesson",
                                color:
                                    AppColors.primaryThreeElementText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 55.w,
                      alignment: Alignment.centerRight,
                      child: Text13Normal(
                        text: "\$${val.price}",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
      ],
    );
  }
}

/*
Container(
          width: 325.w,
          height: 80.h,
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color.fromRGBO(255, 255, 255, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: InkWell(
            onTap:
                () => Navigator.of(context).pushNamed(
                  AppRouteNames.courseDetail,
                  arguments: {"id": value[index].id},
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60.r,
                      width: 60.r,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                            "${AppConstants.IMAGE_UPLOAD_PATH}${value[index].thumbnail}",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 6.w),
                          width: 180.w,
                          child: Text13Normal(
                            text: value[index].name.toString(),
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            maxLine: 1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6.w),
                          width: 180.w,
                          child: Text10Normal(
                            text: "${value[index].lesson_num} Lesson",
                            color: AppColors.primaryThreeElementText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 55.w,
                  alignment: Alignment.centerRight,
                  child: Text13Normal(
                    text: "\$${value[index].price}",
                  ),
                ),
              ],
            ),
          ),
        );

*/
