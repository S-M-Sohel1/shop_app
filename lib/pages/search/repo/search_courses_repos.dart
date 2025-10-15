import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/services/http_util.dart';

class SearchCoursesRepo {
  static Future<CourseListResponseEntity?>
  coursesDefaultSearch() async {
    var response = await HttpUtil().post('api/coursesSearchDefault');
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseListResponseEntity?> coursesSearch(
    SearchRequestEntity? params,
  ) async {
    var response = await HttpUtil().post(
      'api/coursesSearch',
      queryParameters: params?.toJson(),
    );
    return CourseListResponseEntity.fromJson(response);
  }
}
