import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

Future main() async {
  // 위젯 바인딩 초기화 : 웹뷰와 플러터 엔진과의 상호작용을 위함
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(
    const MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 인앱웹뷰 컨트롤러
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      // 플랫폼 상관없이 동작하는 옵션
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true, // URL 로딩 제어
        mediaPlaybackRequiresUserGesture: false, // 미디어 자동 재생
        javaScriptEnabled: true, // 자바스크립트 실행 여부
        javaScriptCanOpenWindowsAutomatically: true, // 팝업 여부
      ),
      // 안드로이드 옵션
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true, // 하이브리드 사용을 위한 안드로이드 웹뷰 최적화
      ),
      // iOS 옵션
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true, // 웹뷰 내 미디어 재생 허용
      ));

  late PullToRefreshController pullToRefreshController; // 당겨서 새로고침 컨트롤러
  String url = ""; // url 주소
  double progress = 0; // 페이지 로딩 프로그레스 바

  @override
  void initState() {
    super.initState();

    // 당겨서 새로고침 컨트롤러 설정
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue, // 새로고침 아이콘 색상
      ),
      // 플랫폼별 새로고침
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    // 시작 페이지
                    initialUrlRequest: URLRequest(
                        url: Uri.parse("https://luvris2.tistory.com/")),
                    // 초기 설정
                    initialOptions: options,
                    // 당겨서 새로고침 컨트롤러 정의
                    pullToRefreshController: pullToRefreshController,
                    // 인앱웹뷰 생성 시 컨트롤러 정의
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    // 페이지 로딩 시 수행 메서드 정의
                    onLoadStart: (controller, url) {
                      setState(() {
                        this.url = url.toString();
                      });
                    },
                    // 안드로이드 웹뷰에서 권한 처리 메서드 정의
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    // URL 로딩 제어
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;
                      // 아래의 키워드가 포함되면 페이지 로딩
                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          // Launch the App
                          await launchUrl(
                            Uri.parse(url),
                          );
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    // 페이지 로딩이 정지 시 메서드 정의
                    onLoadStop: (controller, url) async {
                      // 당겨서 새로고침 중단
                      pullToRefreshController.endRefreshing();
                      setState(() {
                        this.url = url.toString();
                      });
                    },
                    // 페이지 로딩 중 오류 발생 시 메서드 정의
                    onLoadError: (controller, url, code, message) {
                      // 당겨서 새로고침 중단
                      pullToRefreshController.endRefreshing();
                    },
                    // 로딩 상태 변경 시 메서드 정의
                    onProgressChanged: (controller, progress) {
                      // 로딩이 완료되면 당겨서 새로고침 중단
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      // 현재 페이지 로딩 상태 업데이트 (0~100%)
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                  // 로딩 프로그레스 바 표현 여부
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
