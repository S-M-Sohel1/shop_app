import 'package:flutter/material.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';

AppBar buildAppbar({String title=""}) {
  return AppBar(
    // backgroundColor: Colors.white,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(color: const Color.fromARGB(79, 158, 158, 158), height: 1),
    ),
    title: Center(
      child: Text16Normal(text: title, color: AppColors.primaryText),
    ),
  );
}


AppBar buildGlobalAppbar({String title=""}) {
  return AppBar(
    title: Center(
      child: Text16Normal(text: title, color: AppColors.primaryText),
    ),
  );
}