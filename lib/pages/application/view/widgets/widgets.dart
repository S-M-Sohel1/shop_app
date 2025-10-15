import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/pages/home/view/home.dart';
import 'package:learning_app/pages/profile/view/profile.dart';
import 'package:learning_app/pages/search/view/search.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: _bottomContainer(),
    label: "Home",
    backgroundColor: AppColors.primaryBackground,
    activeIcon: _bottomContainer(color: AppColors.primaryElement),
  ),
  BottomNavigationBarItem(
    icon: _bottomContainer(imagePath: ImageRes.search),
    label: "Search",
    backgroundColor: AppColors.primaryBackground,
    activeIcon: _bottomContainer(
      imagePath: ImageRes.search,
      color: AppColors.primaryElement,
    ),
  ),
  BottomNavigationBarItem(
    icon: _bottomContainer(imagePath: ImageRes.play),
    label: "Play",
    backgroundColor: AppColors.primaryBackground,
    activeIcon: _bottomContainer(
      imagePath: ImageRes.play,
      color: AppColors.primaryElement,
    ),
  ),

  BottomNavigationBarItem(
    icon: _bottomContainer(imagePath: ImageRes.message),
    label: "Message",
    backgroundColor: AppColors.primaryBackground,
    activeIcon: _bottomContainer(
      imagePath: ImageRes.message,
      color: AppColors.primaryElement,
    ),
  ),
  BottomNavigationBarItem(
    icon: _bottomContainer(imagePath: ImageRes.profile),
    label: "Profile",
    backgroundColor: AppColors.primaryBackground,
    activeIcon: _bottomContainer(
      imagePath: ImageRes.profile,
      color: AppColors.primaryElement,
    ),
  ),
];

Widget _bottomContainer({
  double width = 15,
  double height = 15,
  String imagePath = ImageRes.home,
  Color color = AppColors.primaryFourElementText,
}) {
  return SizedBox(
    width: width.w,
    height: height.r,
    child: appImageWithColor(imagePath: imagePath, color: color),
  );
}

Widget appScreen({int index = 0}) {
  List<Widget> screens = [
    const Home(),
    const Search(),
    const Center(
      child: AppImage(
        imagePath: ImageRes.play,
        width: 250,
        height: 250,
      ),
    ),
    const Center(
      child: AppImage(
        imagePath: ImageRes.message,
        width: 250,
        height: 250,
      ),
    ),
    const Profile(),
  ];
  return screens[index];
}
