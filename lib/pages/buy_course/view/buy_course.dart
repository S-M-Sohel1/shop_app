import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_app/commons/widgets/text_widgets.dart';
import 'package:learning_app/pages/buy_course/controller/buy_course_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyCourse extends ConsumerStatefulWidget {
  const BuyCourse({super.key});

  @override
  ConsumerState<BuyCourse> createState() => _BuyCourseState();
}

class _BuyCourseState extends ConsumerState<BuyCourse> {
  int _getCourseId() {
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

  late WebViewController _webViewController;
  var loadingProgress = 0;
  bool _isUrlLoaded = false;
  
  @override
  void initState() {
    super.initState();
    // Skip WebView initialization on web platform
    if (kIsWeb) {
      return;
    }
    
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'Pay',
            onMessageReceived: (JavaScriptMessage message) {
              Navigator.of(context).pop(message.message);
            },
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  loadingProgress = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingProgress = progress;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  loadingProgress = 100;
                });
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final courseId = _getCourseId();
    print('Course ID buying: $courseId');
    final courseData = ref.watch(
      buyCourseControllerProvider(index: courseId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Complete Purchase')),
      body: courseData.when(
        data: (checkoutUrl) {
          if (checkoutUrl == null ||
              checkoutUrl.isEmpty ||
              checkoutUrl == "none") {
            return const Center(
              child: Text16Normal(
                text:
                    ' Already purchased or no checkout URL received!!!',
              ),
            );
          }

          // Show message for web platform
          if (kIsWeb) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.web, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'WebView not supported on web platform',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text('Payment URL: $checkoutUrl'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          // Only load URL once
          if (!_isUrlLoaded) {
            _webViewController.loadRequest(Uri.parse(checkoutUrl));
            _isUrlLoaded = true;
          }

          return Stack(
            children: [
              WebViewWidget(controller: _webViewController),
              if (loadingProgress < 100)
                LinearProgressIndicator(
                  color: Colors.green,
                  value: loadingProgress / 100,
                ),
            ],
          );
        },
        error: (error, stackTrace) {
          print('Buy course error: $error');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          );
        },
        loading:
            () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Preparing checkout...'),
                ],
              ),
            ),
      ),
    );
  }
}
