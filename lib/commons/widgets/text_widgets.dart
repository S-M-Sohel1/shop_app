import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_colors.dart';

Text text24Normal({
  String text = '',
  Color color = AppColors.primaryText,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: 24.sp,
      fontWeight: fontWeight,
    ),
  );
}

// Widget Text16Normal({
//   String text = '',
//   Color color = AppColors.primarySecondaryElementText,
// }) {
//   return Text16Normal();
// }

class Text16Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  const Text16Normal({
    super.key,
    this.text = '',
    this.color = AppColors.primarySecondaryElementText,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: 16.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
// Te xt text14Normal({
//   String text = '',
//   Color color = AppColors.primaryThreeElementText,
// }) {
//   return Text14Normal();
// }

class Text14Normal extends StatelessWidget {
  final Color color;
  final String text;
  final FontWeight fontWeight;
  final int? maxLine;
  const Text14Normal({
    super.key,
    this.color = AppColors.primaryThreeElementText,
    this.text = '',
    this.fontWeight = FontWeight.normal,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLine,
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Text9Normal extends StatelessWidget {
  final Color color;
  final String? text;
  const Text9Normal({
    super.key,
    this.color = AppColors.primaryThreeElementText,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primarySecondaryElementText,
        fontSize: 9.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class Text10Normal extends StatelessWidget {
  final Color color;
  final String? text;
  const Text10Normal({
    super.key,
    this.color = AppColors.primaryThreeElementText,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class Text11Normal extends StatelessWidget {
  final Color color;
  final String text;
  final FontWeight fontWeight;
  const Text11Normal({
    super.key,
    this.color = AppColors.primaryThreeElementText,
    this.text = '',
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: 11.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Text12Normal extends StatelessWidget {
  final Color color;
  final String text;
  final FontWeight fontWeight;
  const Text12Normal({
    super.key,
    this.color = AppColors.primaryThreeElementText,
    this.text = '',
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Text13Normal extends StatelessWidget {
  final Color color;
  final String? text;
  final FontWeight fontWeight;
  final int? maxLine;
  final TextAlign textAlign;
  const Text13Normal({
    super.key,
    this.color = AppColors.primaryText,
    this.text = '',
    this.fontWeight = FontWeight.bold,
    this.maxLine = 1,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: 13.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}

Widget textUnderline(String text) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
        color: AppColors.primaryText,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryText,
      ),
    ),
  );
}

class FadeText extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  const FadeText({
    super.key,
    this.color = AppColors.primary_bg,
    this.text = '',
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.fade,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
