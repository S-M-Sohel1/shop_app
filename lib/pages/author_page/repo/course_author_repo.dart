import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/services/http_util.dart';

class CourseAuthorRepo {

 static Future<CourseListResponseEntity> authorCourseList({AuthorRequestEntity? params})async{
       var response= await HttpUtil().post(
        "/api/authorCourseList",
        queryParameters: params?.toJson(),
  );
  print("authorCourseList response: $response");
  return CourseListResponseEntity.fromJson(response);
 }

 static Future<AuthorResponseEntity> courseAuthor({AuthorRequestEntity? params})async{
  var response= await HttpUtil().post(
    "/api/courseAuthor",
    queryParameters: params?.toJson(),
  );
  print("courseAuthor response: $response");
  return AuthorResponseEntity.fromJson(response);
 }

}