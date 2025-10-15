import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_app/commons/utils/image_res.dart';
import 'package:learning_app/pages/welcome/provider/welcome_notifier.dart';
import 'package:learning_app/pages/welcome/view/widgets/widgets.dart';

// final indexProvider=StateProvider<int>((ref) => 0,);
class Welcome extends ConsumerWidget {
  Welcome({super.key});
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = ref.watch(indexDotProvider);
    return Container(
       child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            // color: Colors.red, 
            // margin: EdgeInsets.only(top: 20.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  onPageChanged: (value) {
                    ref.read(indexDotProvider.notifier).state = value;
                  },
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    appOnBoardingPage(
                      _controller,
                      imagePath: ImageRes.reading,
                      title: 'First see learning',
                      subTitle: 'Forget about the paper, now all in one place',
                      index: 1,
                      context: context,
                    ),
                    appOnBoardingPage(
                      _controller,
                      imagePath: ImageRes.man,
                      title: 'Connect with everyone',
                      subTitle:
                          "Always keep in touch with your friends. Let's get connected",
                      index: 2,
                      context: context,
                    ),
                    appOnBoardingPage(
                      _controller,
                      imagePath: ImageRes.boy,
                      title: 'Always fascinated learning',
                      subTitle:
                          "Anywhere, anytime. The time is at your discretion. So study wherever you can",
                      index: 3,
                      context: context,
                    ),
                  ],
                ),
                // Positioned(
                //   // left: 20.w,
                //   bottom: 60.h,
                //   child: DotsIndicator(dotsCount: 3,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   decorator: DotsDecorator(
                //     size: const Size.square(9),

                //   ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
