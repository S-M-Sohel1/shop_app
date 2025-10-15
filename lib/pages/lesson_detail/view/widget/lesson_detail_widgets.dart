import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/models/lesson_entities.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/lesson_detail/controller/lesson_controller.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class LessonVideos extends StatelessWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  final Function syncVideoIndex;
  const LessonVideos({
    super.key,
    required this.lessonData,
    required this.ref,
    required this.syncVideoIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lessonData.length,
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: 325.w,
          height: 80.h,
          decoration: appBoxShadow(
            radius: 10,
            bR: 3,
            sR: 2,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: InkWell(
            onTap: () {
              syncVideoIndex(index);
              var vidUrl = lessonData[index].url;

              ref
                  .read(lessonDataControllerProvider.notifier)
                  .playNextVid(vidUrl!);
            },
            child: Row(
              children: [
                BoxDecorationImage(
                  imagePath:
                      "${AppConstants.IMAGE_UPLOAD_PATH}${lessonData[index].thumbnail}",
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text13Normal(text: lessonData[index].name),
                    ],
                  ),
                ),
                Container(),
                const AppImage(
                  imagePath: ImageRes.arrowRight,
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
