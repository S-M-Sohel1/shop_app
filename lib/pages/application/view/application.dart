
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/pages/application/provider/application_nav_notifier.dart';
import 'package:learning_app/pages/application/view/widgets/widgets.dart';

class Application extends ConsumerWidget {
  const Application({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index= ref.watch(applicationNavIndexProvider) ;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: appScreen(index: index),
          bottomNavigationBar: Container(
            width: 375.w,
            height: 58.h,
           decoration: appBoxShadowRadius(), 
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (value){
             ref.read(applicationNavIndexProvider.notifier).changeIndex(value);
              },
              elevation: 0,

              items: bottomTabs,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.primaryElement,
              unselectedItemColor: AppColors.primaryFourElementText,

            ),
          ),
        ),
      ),
    );
  }
}