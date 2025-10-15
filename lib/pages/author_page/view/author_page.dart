import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_bar.dart';
import 'package:learning_app/commons/widgets/button_widgets.dart';
import 'package:learning_app/pages/author_page/controller/author_controller.dart';
import 'package:learning_app/pages/author_page/view/widget/author_page_widgets.dart';

class AuthorPage extends ConsumerStatefulWidget {
  const AuthorPage({super.key});

  @override
  ConsumerState<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends ConsumerState<AuthorPage> {
  var user_token;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      var temp = args as Map;
      user_token = temp['token'];
    } else {
      user_token = null;
    }

    ref.watch(authorControllerProvider.notifier).init(user_token.toString());
    ref
        .watch(courseAuthorControllerProvider.notifier)
        .init(user_token.toString());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var authorinfo = ref.watch(courseAuthorControllerProvider);
    var courseinfo = ref.watch(authorControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppBar(title: "Author page"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            switch (authorinfo) {
              AsyncData(:final value) =>
                value == null
                    ? SizedBox(
                      height: 600.h,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black26,
                        ),
                      ),
                    )
                    : SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          AuthorMenu(authorItem: value),
                          AuthorDescription(authorItem: value),
                          SizedBox(height: 20.h),
                          AppButton(
                            buttonName: "Go Chat",
                            func: () {
                              print("I am tapped");
                            },
                          ),
                          AuthorAllCourses(
                            value: courseinfo.value ?? [],
                          ),
                        ],
                      ),
                    ),
              _ => SizedBox(
                height: 600.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
