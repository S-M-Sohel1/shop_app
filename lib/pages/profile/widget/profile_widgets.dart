import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/profile/controller/profile_controller.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileImage = ref.read(profileControllerProvider);
        // print("--------${profileImage.avatar}------");
        return Container(
          alignment: Alignment.bottomRight,
          width: 80.w,
          height: 80.h,
          decoration:
              profileImage.avatar == null
                  ? BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.r),
                    image: const DecorationImage(
                      image: AssetImage(ImageRes.headPic),
                    ),
                  )
                  : BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: NetworkImage(
                        "${AppConstants.SERVER_API_URL}${profileImage.avatar}",
                      ),
                    ),
                  ),
          child: AppImage(
            imagePath: ImageRes.editImage,
            width: 25.w,
            height: 25.h,
          ),
        );
      },
    );
  }
}

class ProfileNameWidget extends StatelessWidget {
  const ProfileNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        // print("--------${profileImage.avatar}------");
        return Container(
          margin: EdgeInsets.only(top: 12.h),
          child: Text13Normal(
            text:
                profileName.name != null ? "${profileName.name}" : "",
          ),
        );
      },
    );
  }
}

class ProfileDescriptionWidget extends StatelessWidget {
  const ProfileDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var profileName = ref.read(profileControllerProvider);
        // print("--------${profileImage.avatar}------");
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          margin: EdgeInsets.only(top: 5.h),
          child: Text9Normal(
            text:
                profileName.description != null
                    ? "${profileName.description}"
                    : "I am a Flutter developer. I love coding and sharing knowledge with others. I am passionate about building beautiful and functional mobile applications.",
          
          
          ),
        );
      },
    );
  }
}
