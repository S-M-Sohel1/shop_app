import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_colors.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/commons/widgets/app_box_shadow.dart';
import 'package:learning_app/commons/widgets/app_textfield.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  const AppSearchBar({super.key, this.onTap, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 280.w,
          height: 40.h,
          decoration: appBoxShadow(
            color: AppColors.primaryBackground,
            boxBorder: Border.all(
              color: AppColors.primaryFourElementText,
            ),
          ),
          child: Container(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 17.w),
                  child: const AppImage(
                    imagePath: ImageRes.searchIcon,
                  ),
                ),
                SizedBox(
                  width: 240.w,
                  height: 40.h,
                  child: AppTextFieldOnly(
                    width: 240,
                    height: 40,
                    hintText: "Search your course...",
                    func: onChanged,
                    search: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: appBoxShadow(
              boxBorder: Border.all(color: AppColors.primaryElement),
            ),
            child: const AppImage(imagePath: ImageRes.searchButton),
          ),
        ),
      ],
    );
  }
}
