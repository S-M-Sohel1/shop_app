import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_app/commons/utils/app_bar.dart';
import 'package:learning_app/pages/profile/courses_bought/controller/courses_bought_controller.dart';
import 'package:learning_app/pages/profile/courses_bought/view/widget/courses_bought_widget.dart';

class CoursesBought extends ConsumerWidget {
  const CoursesBought({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesList = ref.watch(coursesBoughtControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppBar(title: "Courses Bought"),
      body: switch (coursesList) {
        AsyncData(:final value) =>
          value == null
              ? const Center(child: CircularProgressIndicator())
              : CoursesBoughtWidget(value: value),
        AsyncError(:final error) => Center(
          child: Text("Error: $error"),
        ),
        _ => const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.red,
              strokeWidth: 2,
            ),
          ),
        ),
      },
    );
  }
}
