import 'package:learning_app/commons/models/course_entities.dart';
import 'package:learning_app/pages/author_page/repo/course_author_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'author_controller.g.dart';

@riverpod
class AuthorController extends _$AuthorController {
  @override
  FutureOr<List<CourseItem>?> build() {
    return [];
  }

  void init(String token) {
    loadCourseData(token);
  }

  loadCourseData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var response = await CourseAuthorRepo.authorCourseList(
      params: authorRequestEntity,
    );
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    } else {
      state = const AsyncValue.data([]);
    }
  }
}

@riverpod
class CourseAuthorController extends _$CourseAuthorController {
  @override
  FutureOr<AuthorItem?> build() {
    return null;
  }

  void init(String token) {
    loadAuthorData(token);
  }

  loadAuthorData(String token) async {
    AuthorRequestEntity authorRequestEntity = AuthorRequestEntity();
    authorRequestEntity.token = token;
    var response = await CourseAuthorRepo.courseAuthor(
      params: authorRequestEntity,
    );
    if (response.code == 200) {
      state = AsyncValue.data(response.data);
    } else {
      state = const AsyncValue.data(null);
    }
  }
}
