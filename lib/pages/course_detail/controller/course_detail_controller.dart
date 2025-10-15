import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/models/lesson_entities.dart';
import 'package:learning_app/pages/course_detail/repo/course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'course_detail_controller.g.dart';

@riverpod
// ignore: deprecated_member_use_from_same_package
Future<CourseItem?> courseDetailController(
  CourseDetailControllerRef ref,
  {required int index}
) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final response = await CourseRepo.courseDetail(
    courseRequestEntity,
  );
  if (response!.code == 200) {
    return response.data;
  } else {
    print("Error: ${response.code}");
  }
  return null;
}


@riverpod
Future<List<LessonItem>?> courseLessonListController(
  CourseLessonListControllerRef ref, {
  required int index,
}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;

  final response = await CourseRepo.courseLessonList(
    params: lessonRequestEntity,
  );

  if (response.code == 200) {
    return response.data;
  } else {
    print(response.code);
  }
  return null;
}