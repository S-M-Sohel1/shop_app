import 'package:learning_app/commons/models/base_entities.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/services/http_util.dart';

class BuyCourseRepo {
  static Future<BaseResponseEntity?> buyCourse(
    CourseRequestEntity? params,
  ) async {
    var response = await HttpUtil().post(
      'api/checkout',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}
