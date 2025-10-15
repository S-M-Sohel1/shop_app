import 'package:learning_app/commons/models/lesson_entities.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/pages/lesson_detail/repo/lesson_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'lesson_controller.g.dart';

VideoPlayerController? videoPlayerController;

@riverpod
Future<void> lessonDetailController(
  LessonDetailControllerRef ref, {
  required int index,
}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;

  final response = await LessonRepo.courseLessonDetail(
    params: lessonRequestEntity,
  );

  if (response.code == 200) {
    // print("response.data: ${response.data!.elementAt(0).video?.elementAt(0).url}");
    var url =
        "${AppConstants.IMAGE_UPLOAD_PATH}${response.data![0].video?[0].url}";

    videoPlayerController = VideoPlayerController.network(url);

    var initializeVideoPlayerFuture =
        videoPlayerController?.initialize();

    LessonVideo vidInstance = LessonVideo(
      lessonItem: response.data!.elementAt(0).video ?? [],
      initializeVideoPlayer: initializeVideoPlayerFuture,
      url: url,
      isPlay: true,
    );
    videoPlayerController?.play();
    ref
        .read(lessonDataControllerProvider.notifier)
        .updateLessonData(vidInstance);
  } else {
    print(response.code);
  }
}

//grabs the changed url and play the video
@riverpod
class LessonDataController extends _$LessonDataController {
  @override
  FutureOr<LessonVideo> build() async {
    return LessonVideo();
  }

  void updateLessonData(LessonVideo lessons) {
    update((data) => lessons);
    // update(
    //   (data) => data.copyWith(
    //     url: lessons.url,
    //     initializeVideoPlayer: lessons.initializeVideoPlayer,
    //     isPlay: lessons.isPlay,
    //     lessonItem: lessons.lessonItem,
    //   ),
    // );
  }

  void playPause(bool isplay) {
    update((data) => data.copyWith(isPlay: isplay));
  }

  void playNextVid(String? url) async {
    if (videoPlayerController != null) {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }

    update(
      (data) =>
          data.copyWith(initializeVideoPlayer: null, isPlay: false),
    );

    var vidurl = "${AppConstants.IMAGE_UPLOAD_PATH}$url";
    videoPlayerController = VideoPlayerController.network(vidurl);
    var initializeVideoPlayerFuture = videoPlayerController
        ?.initialize()
        .then((value) {
          videoPlayerController?.seekTo(Duration(seconds: 0));
          videoPlayerController?.play();
        });
    update(
      (data) => data.copyWith(
        initializeVideoPlayer: initializeVideoPlayerFuture,
        isPlay: true,
      ),
    );
  }
}
