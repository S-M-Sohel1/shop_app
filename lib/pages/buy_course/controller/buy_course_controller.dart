import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/models/lesson_entities.dart';
import 'package:learning_app/pages/buy_course/repo/buy_course_repo.dart';
import 'package:learning_app/pages/course_detail/repo/course_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'buy_course_controller.g.dart';

@riverpod
// ignore: deprecated_member_use_from_same_package
Future<String?> BuyCourseController(
  BuyCourseControllerRef ref, {
  required int index,
}) async {
  CourseRequestEntity courseRequestEntity = CourseRequestEntity();
  courseRequestEntity.id = index;
  final response = await BuyCourseRepo.buyCourse(courseRequestEntity);
  if (response!.code == 200) {
    return response.data;
  } else {
    print("Error: ${response.code}");
  }
  return null;
}
