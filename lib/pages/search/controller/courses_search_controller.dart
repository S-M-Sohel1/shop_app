import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/pages/search/repo/search_courses_repos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'courses_search_controller.g.dart';

@Riverpod(keepAlive: true)
class CoursesSearchController extends _$CoursesSearchController {
  @override
  Future<List<CourseItem>?> build() async {
    var response = await SearchCoursesRepo.coursesDefaultSearch();
    if (response?.code == 200) {
      return response?.data;
    }

    return null;
  }

  reloadSearchData() async {
    var response = await SearchCoursesRepo.coursesDefaultSearch();
    if (response?.code == 200) {
      state = AsyncValue.data(response?.data);
      return;
    }

    state = const AsyncValue.data([]);
  }

  searchData(String search) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = search;

    var response = await SearchCoursesRepo.coursesSearch(
      searchRequestEntity,
    );
    if (response?.code == 200) {
      state = AsyncValue.data(response?.data);
    } else {
      state = const AsyncValue.data([]);
    }
  }
}
