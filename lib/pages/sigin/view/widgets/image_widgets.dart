import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';

// Widget appImage({

// }) {
//   return Image.asset(imagePath, width: width.w, height: height.h);
// }
class AppImage extends StatelessWidget {
 final String imagePath;
  final double width;
  final double height;
  const AppImage({super.key, this.imagePath=ImageRes.user, this.width=16, this.height=16});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath.isEmpty ? ImageRes.user : imagePath, width: width.w, height: height.h);
  }
}

Widget appImageWithColor({
  String imagePath = ImageRes.user,
  double width = 16,
  double height = 16,
  Color color = AppColors.primaryElement,
}) {
  return Image.asset(imagePath, width: width.w, height: height.h,
  color: color,);
}
