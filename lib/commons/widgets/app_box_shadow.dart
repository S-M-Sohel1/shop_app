import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/models/lesson_entities.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';

BoxDecoration appBoxShadow({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? boxBorder,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius.r),
    border: boxBorder,
    boxShadow: [
      const BoxShadow(
        color: Color.fromARGB(26, 158, 158, 158),
        spreadRadius: 1,
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
  );
}

BoxDecoration appBoxShadowRadius({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? border,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.h),
      topRight: Radius.circular(20.h),
    ),
    border: border,
    boxShadow: [
      const BoxShadow(
        color: Color.fromARGB(26, 158, 158, 158),
        spreadRadius: 1,
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
  );
}

BoxDecoration appBoxDecorationField({
  Color color = AppColors.primaryBackground,
  double radius = 15,
  Color borderColor = AppColors.primaryFourElementText,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius.r),
    border: Border.all(color: borderColor),
  );
}

class BoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final BoxFit fit;
  final CourseItem? courseItem;
  final Function()? func;
  const BoxDecorationImage({
    super.key,
    this.width = 40,
    this.height = 40,
    this.imagePath = ImageRes.profile,
    this.fit = BoxFit.fitHeight,
    this.courseItem,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    // print('hi');
    // print(courseItem?.name);
    return GestureDetector(
      onTap: func,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        imageBuilder: (context, imageProvider) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(fit: fit, image: imageProvider),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child:
                courseItem == null
                    ? Container()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: FadeText(text: courseItem!.name!),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20.w,
                            bottom: 10.h,
                          ),
                          child: FadeText(
                            text:
                                "${courseItem!.lesson_num!} Lessons",
                          ),
                        ),
                      ],
                    ),
          );
        },
        placeholder: (context, url) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        },
        errorWidget: (context, url, error) {
          return Image.asset(ImageRes.user);
        },
      ),
    );
  }
}

BoxDecoration networkImageDecoration(String imageUrl) {
  return BoxDecoration(
    image: DecorationImage(image: NetworkImage(imageUrl)),
  );
}
