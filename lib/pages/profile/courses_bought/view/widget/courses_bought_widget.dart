import 'package:flutter/material.dart';
import 'package:learning_app/commons/models/course_entities.dart';

import 'package:learning_app/commons/widgets/courses_tile.dart';

class CoursesBoughtWidget extends StatelessWidget {
  final List<CourseItem> value;
  const CoursesBoughtWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return CoursesTile(value: value);
  }
}
