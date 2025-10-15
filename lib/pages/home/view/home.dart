import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/widgets/search_widgets.dart';
import 'package:learning_app/pages/home/controller/home_controller.dart';
import 'package:learning_app/pages/home/widgets/home_widgets.dart';
import 'package:learning_app/pages/search/controller/courses_search_controller.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController _controller;

  @override
  void didChangeDependencies() {
    _controller = PageController(
      initialPage: ref.watch(homeScreenBannerDotsProvider),
    );
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(ref),
      body: RefreshIndicator(
        onRefresh: () async {
          // Handle refresh logic
          ref
              .refresh(homeCourseListProvider.notifier)
              .fetchCourseList();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const HelloText(),
                const UserName(),
                SizedBox(height: 20.h),
                AppSearchBar(
                  onChanged: (search) {
                    // ref
                    //     .read(
                    //       coursesSearchControllerProvider.notifier,
                    //     )
                    //     .searchData(search);
                  },
                ),
                SizedBox(height: 20.h),
                HomeBanner(ref: ref, controller: _controller),
                const HomeMenuBar(),
                CourseItemGrid(ref: ref),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
