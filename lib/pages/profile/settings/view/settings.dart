import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/routes/app_route_names.dart';
import 'package:learning_app/commons/utils/app_bar.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/global.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGlobalAppBar(title: "Settings"),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Confirm Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Global.storageService.remove(
                          AppConstants.STORAGE_USER_PROFILE_KEY,
                        );
                        Global.storageService.remove(
                          AppConstants.STORAGE_USER_TOKEN_KEY,
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouteNames.signIn,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text("Confirm"),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            height: 100.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageRes.logOut),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
