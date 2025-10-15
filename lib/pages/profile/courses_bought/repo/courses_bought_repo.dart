import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/services/http_util.dart';

class CoursesBoughtRepo {
  static Future<CourseListResponseEntity?> coursesBought() async {
    var response = await HttpUtil().post('api/coursesBought');
    return CourseListResponseEntity.fromJson(response);
  }
}
