import 'package:flutter/material.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';

AppBar buildAppBar({String title = ''}) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(
        color: AppColors.primaryThreeElementText.withOpacity(0.2),
        height: 1,
      ),
    ),
    centerTitle: true,
    title: Text16Normal(
      text: title,
      color: AppColors.primaryText,
      fontWeight: FontWeight.bold,
    ),
  );
}

AppBar buildGlobalAppBar({String title = ''}) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,

    centerTitle: true,
    title: Text16Normal(
      text: title,
      color: AppColors.primaryText,
      fontWeight: FontWeight.bold,
    ),
  );
}
