import 'package:learning_app/commons/api/course_api.dart';
import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/commons/models/entities.dart';
import 'package:learning_app/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() => 0;
  void setIndex(int index) {
    state = index;
  }
}

@Riverpod(keepAlive: true)
class HomeUserProfile extends _$HomeUserProfile {
  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

@Riverpod(keepAlive: true)
class HomeCourseList extends _$HomeCourseList {
  Future<List<CourseItem>?> fetchCourseList() async {
   var result= await CourseApi.courseList();
   if(result.code==200){
    return result.data;
   }
   return null;
  }

  @override
  Future<List<CourseItem>?> build() async{
    return fetchCourseList();
  }
}