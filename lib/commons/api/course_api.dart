import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/services/http_util.dart';

class CourseApi {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('api/courseList');
    // print(response.data);
    return CourseListResponseEntity.fromJson(response);
  }
}
