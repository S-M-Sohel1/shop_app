import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/app_bar.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/popup_messages.dart';
import 'package:learning_app/pages/lesson_detail/controller/lesson_controller.dart';
import 'package:learning_app/pages/lesson_detail/view/widget/lesson_detail_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';
import 'package:video_player/video_player.dart';

class LessonDetail extends ConsumerStatefulWidget {
  const LessonDetail({super.key});

  @override
  ConsumerState<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends ConsumerState<LessonDetail> {
  // @override
  // void initState(){

  //   super.initState();
  // }
  int _getLessonId() {
    try {
      final routeArguments =
          ModalRoute.of(context)?.settings.arguments;
      // print('Raw route arguments: $routeArguments');

      if (routeArguments == null) {
        // print('No route arguments found');
        return -1;
      }

      if (routeArguments is Map<String, dynamic>) {
        final id = routeArguments['id'];
        if (id != null && id is int) {
          // print('Lesson ID found: $id');
          return id;
        }
      } else if (routeArguments is Map) {
        final arguments = Map<String, dynamic>.from(routeArguments);
        final id = arguments['id'];
        if (id != null && id is int) {
          // print('Lesson ID found: $id');
          return id;
        }
      }

      // print('No valid lesson ID found');
      return -1;
    } catch (e) {
      // print('Error getting lesson ID: $e');
      return -1;
    }
  }

  var videoIndex = 0;

  @override
  void dispose() {
    videoPlayerController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessonId = _getLessonId();

    if (lessonId == -1) {
      return Scaffold(
        appBar: buildGlobalAppbar(title: 'Lesson Detail'),
        body: const Center(
          child: Text(
            'No lesson selected. Please navigate from lesson list.',
          ),
        ),
      );
    }
    var lessonData = ref.watch(lessonDataControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: lessonData.when(
          data: (data) {
            if (data.lessonItem.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Container(
                  width: 325.w,
                  height: 200.h,
                  decoration: networkImageDecoration(
                    "${AppConstants.IMAGE_UPLOAD_PATH}${data.lessonItem[0].thumbnail}",
                  ),
                  child: FutureBuilder(
                    future: data.initializeVideoPlayer,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Stack(
                          children: [
                            VideoPlayer(videoPlayerController!),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        videoIndex--;
                        if (videoIndex < 0) {
                          videoIndex = 0;
                          toastInfo("Already first video");
                          return;
                        }

                        var vidUrl = data.lessonItem[videoIndex].url;
                        ref
                            .read(
                              lessonDataControllerProvider.notifier,
                            )
                            .playNextVid(vidUrl);
                      },
                      child: const AppImage(
                        width: 40,
                        height: 40,
                        imagePath: ImageRes.left,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    GestureDetector(
                      onTap: () {
                        if (data.isPlay) {
                          videoPlayerController?.pause();
                          ref
                              .read(
                                lessonDataControllerProvider.notifier,
                              )
                              .playPause(false);
                        } else {
                          videoPlayerController?.play();
                          ref
                              .read(
                                lessonDataControllerProvider.notifier,
                              )
                              .playPause(true);
                        }
                      },
                      child:
                          data.isPlay
                              ? const AppImage(
                                width: 40,
                                height: 40,
                                imagePath: ImageRes.pause,
                              )
                              : const AppImage(
                                width: 40,
                                height: 40,
                                imagePath: ImageRes.play,
                              ),
                    ),
                    SizedBox(width: 15.w),
                    GestureDetector(
                      onTap: () {
                        videoIndex++;
                        if (videoIndex >= data.lessonItem.length) {
                          videoIndex = data.lessonItem.length - 1;
                          toastInfo("Already last video");
                          return;
                        }
                        var vidUrl = data.lessonItem[videoIndex].url;
                        ref
                            .read(
                              lessonDataControllerProvider.notifier,
                            )
                            .playNextVid(vidUrl);
                      },
                      child: const AppImage(
                        width: 40,
                        height: 40,
                        imagePath: ImageRes.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: LessonVideos(
                    lessonData: data.lessonItem,
                    ref: ref,
                    syncVideoIndex: syncVideoIndex,
                  ),
                ),
              ],
            );
          },
          error: (error, stack) {
            return Center(child: Text('Error: $error'));
          },
          loading:
              () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void syncVideoIndex(int index) {
    videoIndex = index;
  }
}
