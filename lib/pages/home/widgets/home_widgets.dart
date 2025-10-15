import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/routes/app_route_names.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/global.dart';
import 'package:learning_app/pages/home/controller/home_controller.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

// Widget helloText() {
//   return HelloText();
// }

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: text24Normal(
        text: "Hello, ",
        color: AppColors.primaryThreeElementText,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Widget userName() {
//   return UserName();
// }

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = Global.storageService.getUserProfile();
    final userName =
        userProfile.name ?? 'Guest'; // Provide default name

    return Container(
      child: text24Normal(
        text: userName,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Widget banner({required WidgetRef ref, required PageController controller }) {

//   return HomeBanner();
// }

class HomeBanner extends StatelessWidget {
  final PageController controller;
  final WidgetRef ref;
  const HomeBanner({
    super.key,
    required this.controller,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 325.w,
          height: 160.h,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              ref
                  .read(homeScreenBannerDotsProvider.notifier)
                  .setIndex(index);
            },
            children: [
              bannerContainer(imagePath: ImageRes.banner1),
              bannerContainer(imagePath: ImageRes.banner2),
              bannerContainer(imagePath: ImageRes.banner3),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        DotsIndicator(
          position:
              ref.watch(homeScreenBannerDotsProvider).toDouble(),
          dotsCount: 3,
          mainAxisAlignment: MainAxisAlignment.center,

          decorator: DotsDecorator(
            size: Size.square(9.r),
            activeSize: Size(36.w, 8.h),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
      ],
    );
  }
}

Widget bannerContainer({required String imagePath}) {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.fill,
      ),
    ),
  );
}

AppBar homeAppBar(WidgetRef ref) {
  var profileState = ref.watch(homeUserProfileProvider);
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppImage(
            width: 18.w,
            height: 12.h,
            imagePath: ImageRes.menu,
          ),
          profileState.when(
            data:
                (data) => GestureDetector(
                  child: BoxDecorationImage(
                    imagePath:
                        "${AppConstants.SERVER_API_URL}${data.avatar ?? 'api/uploads/default.png'}",
                  ),
                ),
            error:
                (err, stack) => AppImage(
                  width: 18.w,
                  height: 12.h,
                  imagePath: ImageRes.profile,
                ),
            loading: () => Container(),
          ),
        ],
      ),
    ),
  );
}

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //see all courses
        Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text16Normal(
                text: 'Choice your course',
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
              GestureDetector(
                child: const Text10Normal(text: 'See all'),
              ),
            ],
          ),
        ),
        //course item button
        SizedBox(height: 20.h),
        Row(
          children: [
            Container(
              decoration: appBoxShadow(
                color: AppColors.primaryElement,
                radius: 7,
              ),
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
                top: 5.h,
                bottom: 5.h,
              ),
              child: const Text11Normal(text: 'All'),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: const Text11Normal(
                text: 'Popular',
                color: AppColors.primaryThreeElementText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: const Text11Normal(
                text: 'Newest',
                color: AppColors.primaryThreeElementText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CourseItemGrid extends StatelessWidget {
  final WidgetRef ref;
  const CourseItemGrid({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(homeCourseListProvider);

    return courseState.when(
      data:
          (data) => GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
            itemCount: data!.length,
            itemBuilder: (_, int index) {
              // print('hahahh:${data[index].thumbnail}');
              return BoxDecorationImage(
                imagePath:
                    "${AppConstants.IMAGE_UPLOAD_PATH}${data[index].thumbnail}",
                    fit: BoxFit.cover,
                    courseItem: data[index],
                    func: (){
                      // print('you clicked ${data[index].id}');
                      // print('data: ${data}');
                      Navigator.of(context).pushNamed(AppRouteNames.courseDetail, arguments: {
                        "id": data[index].id!
                      });
                    },
              );
            }
          ),
      error: (error, stackTrace) {
        // print(error.toString());
        // print(stackTrace.toString());
        return const Center(child: Text("Error"));
      },
      loading: () => const Center(child: Text("Loading  ...")),
    );
  }
}
