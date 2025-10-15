import 'package:flutter/material.dart';
import 'package:learning_app/commons/routes/app_route_names.dart';
import 'package:learning_app/global.dart';
import 'package:learning_app/pages/application/view/application.dart';
import 'package:learning_app/pages/author_page/view/author_page.dart';
import 'package:learning_app/pages/buy_course/view/buy_course.dart';
import 'package:learning_app/pages/course_detail/view/course_detail.dart';
import 'package:learning_app/pages/home/view/home.dart';
import 'package:learning_app/pages/lesson_detail/view/lesson_detail.dart';
import 'package:learning_app/pages/profile/courses_bought/view/courses_bought.dart';
import 'package:learning_app/pages/profile/settings/view/settings.dart';
import 'package:learning_app/pages/sigin/view/sign_in.dart';
import 'package:learning_app/pages/sign_up/view/sign_up.dart';
import 'package:learning_app/pages/welcome/view/welcome.dart';

class AppPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path: AppRouteNames.welcome, page: Welcome()),
      RouteEntity(path: AppRouteNames.signIn, page: const SignIn()),
      RouteEntity(path: AppRouteNames.signUp, page: const SignUp()),
      RouteEntity(path: AppRouteNames.application, page: const Application()),
      RouteEntity(path: AppRouteNames.home, page: const Home()),
      RouteEntity(path: AppRouteNames.courseDetail, page: const CourseDetail()),
      RouteEntity(path: AppRouteNames.lessonDetail, page: const LessonDetail()),
      RouteEntity(path: AppRouteNames.buyCourse, page: const BuyCourse()),
      RouteEntity(path: AppRouteNames.settings, page: const Settings()),
      RouteEntity(path: AppRouteNames.coursesBought, page: const CoursesBought()),
      RouteEntity(path: AppRouteNames.authorPage, page: const AuthorPage()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    // print("Route is: ${settings.name}");

    if (settings.name != null) {
      //get the element that matches with current screen name
      var result = routes().where((element) => element.path == settings.name);
      bool deviceOpen = Global.storageService.getDeviceFirstOpen();
      // print(deviceOpen);

      if (result.first.path == AppRouteNames.welcome && deviceOpen) {
        bool logged = Global.storageService.isLoggedIn();
        if (logged) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Application()),
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: SignIn()),
            settings: settings,
          );
        }
      }
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: result.first.page),
        settings: settings,
      );
    }
    return MaterialPageRoute(builder: (_) => Scaffold(body: Welcome()), settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}
