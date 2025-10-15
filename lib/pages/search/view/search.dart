import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/commons/utils/app_bar.dart';
import 'package:learning_app/commons/widgets/search_widgets.dart';
import 'package:learning_app/pages/search/controller/courses_search_controller.dart';
import 'package:learning_app/pages/search/view/widgets/search_widgets.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchProvider = ref.watch(coursesSearchControllerProvider);
    return Scaffold(
      appBar: buildAppBar(title: "Search Courses"),
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .watch(coursesSearchControllerProvider.notifier)
              .reloadSearchData();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                AppSearchBar(
                  onChanged: (search) {
                    ref
                        .read(
                          coursesSearchControllerProvider.notifier,
                        )
                        .searchData(search);
                  },
                ),
                switch (searchProvider) {
                  AsyncData(:final value) =>
                    value!.isEmpty
                        ? const CircularProgressIndicator()
                        : SearchWidget(value: value),
                  AsyncError(:final error) => Center(
                    child: Text("Error: $error"),
                  ),
                  _ => const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
