import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_bar.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/pages/profile/widget/profile_courses.dart';
import 'package:learning_app/pages/profile/widget/profile_list_items.dart';
import 'package:learning_app/pages/profile/widget/profile_widgets.dart';
import 'package:learning_app/pages/sigin/view/widgets/image_widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var profileImage;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildGlobalAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(),
              ProfileNameWidget(),
              ProfileDescriptionWidget(),
              SizedBox(height: 20),
              ProfileCourses(),
              ProfileListItems()
            ],
          ),
        ),
      ),
    );
  }
}
