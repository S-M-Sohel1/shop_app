import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/app_bar.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/course_detail/controller/course_detail_controller.dart';
import 'package:learning_app/pages/course_detail/view/widget/course_detail_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  int _getCourseId() {
    try {
      final routeArguments =
          ModalRoute.of(context)?.settings.arguments;
      // print('Raw route arguments: $routeArguments');

      if (routeArguments == null) {
        // print('No route arguments found');
        return -1;
      }

      if (routeArguments is Map<String, dynamic>) {
        final id = routeArguments['id'];
        if (id != null && id is int) {
          // print('Course ID found: $id');
          return id;
        }
      } else if (routeArguments is Map) {
        final arguments = Map<String, dynamic>.from(routeArguments);
        final id = arguments['id'];
        if (id != null && id is int) {
          // print('Course ID found: $id');
          return id;
        }
      }

      // print('No valid course ID found');
      return -1;
    } catch (e) {
      // print('Error getting course ID: $e');
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseId = _getCourseId();

    if (courseId == -1) {
      return Scaffold(
        appBar: buildGlobalAppbar(title: 'Course Detail'),
        body: const Center(
          child: Text(
            'No course selected. Please navigate from course list.',
          ),
        ),
      );
    }

    var courseData = ref.watch(
      courseDetailControllerProvider(index: courseId),
    );
    var lessonData = ref.watch(
      courseLessonListControllerProvider(index: courseId),
    );
    print(courseData);
    return Scaffold(
      appBar: buildGlobalAppbar(title: 'Course Detail'),
      body: Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              courseData.when(
                data: (data) {
                  if (data == null) {
                    return const Center(child: Text('No data found'));
                  }
                  return Column(
                    children: [
                      CourseDetailThumbnail(courseItem: data),
                      SizedBox(height: 10.h),
                      AuthorDetails(data: data),
                      CourseDetailDescription(courseItem: data),
                      SizedBox(height: 20.h),
                      CourseDetailGoBuy(courseItem: data),
                      SizedBox(height: 20.h),
                      CourseDetailIncludes(courseItem: data),
                      SizedBox(height: 20.h),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  print('Error: $error');
                  return Center(child: Text('Error: $error'));
                },
                loading: () {
                  return SizedBox(
                    height: 500.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              lessonData.when(
                data: (data) {
                  if (data == null) {
                    return const Center(child: Text('No data found'));
                  }
                  return LessonInfo(lessonData: data, ref: ref);
                },
                error: (error, stackTrace) {
                  print('Error: $error');
                  return Center(child: Text('Error: $error'));
                },
                loading: () {
                  return SizedBox(
                    height: 500.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
