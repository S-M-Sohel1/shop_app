import 'package:flutter/material.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/widgets/courses_tile.dart';

class SearchWidget extends StatelessWidget {
  final List<CourseItem> value;
  const SearchWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: CoursesTile(value: value),
    );
  }
}
