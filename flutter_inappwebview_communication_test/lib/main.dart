import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
                    initialData: InAppWebViewInitialData(data: """
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InAppWebview Web-App Communication Test</title>
    <script>
        window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
            /* 웹에서 앱에게 데이터를 보내고 받는 핸들러
            * APP : onWebViewCreated에서 addJavaScriptHandler를 정의
            * WEB : window.flutter_inappwebview.callHandler를 사용하여 APP에서 정의한 핸들러 이름 호출
            *		    두번째 파라미터부터는 앱으로 보낼 데이터들을 나열
            *       callHandler ( 핸들러이름, 데이터1, 데이터2, ...)
            */

            // 웹에서 앱으로 데이터 보내기
            window.flutter_inappwebview.callHandler('web2app', 'Hello World!', ['Eunbyeol Ko', 33]);

            // 앱 데이터 웹으로 받기
            window.flutter_inappwebview.callHandler('app2web')
                .then(function(result) {
                    // 코드 작성 : 예시 코드에서는 앱에서 받은 데이터를 alert로 보여주도록 함
                    alert(result);
                });
                
            // 웹과 앱 양방향 통신하기
            window.flutter_inappwebview.callHandler('WebAppDataExchange', 1)
                .then(function(result) {
                    // 코드 작성 : 예시 코드에서는 앱에서 받은 데이터를 alert로 보여주도록 함
                    // JSON 타입으로 반환하였기 때문에 JSON.stringify를 이용하여 JSON 타입으로 변환
                    alert(JSON.stringify(result['result']));
                });
        });
    </script>
</head>
<body>
  <center>
    <h2>InAppWebview</h2>
    <h4>Web-App Data Exchange Test</h4>
</body>
</html>
                    """),
                    // 초기 설정
                    initialOptions: options,
                    // 인앱웹뷰 생성 시 컨트롤러 정의
                    onWebViewCreated: (controller) {
                      /* 웹에서 앱과 통신할 수 있는 핸들러를 정의
                      * handlerName : 핸들러명
                      * callback : 웹에서 보낸 데이터
                      * return : 웹으로 보낼 데이터
                      */

                      controller.addJavaScriptHandler(
                          handlerName: 'app2web',
                          callback: (args) {
                            return 'Hello World!';
                          });

                      controller.addJavaScriptHandler(
                          handlerName: 'web2app',
                          callback: (args) {
                            // 수행 코드 작성 : 예시 코드에서는 단순히 print로 받은 데이터를 콘솔에 출력함
                            print('web2app : recieve data ===> $args');
                          });

                      controller.addJavaScriptHandler(
                          handlerName: 'WebAppDataExchange',
                          callback: (args) {
                            // 수행 코드 작성 : 예시 코드에서는 단순히 print로 받은 데이터를 콘솔에 출력함
                            // Web-App Data Exchange : recieve data
                            print(
                                'Web-App Data Exchange : recieve data ===> $args');

                            // 받는 값에 따른 로직 처리 : 예시 코드에서는 값이 1이면 result 성공값 반환
                            if (args[0] == 1) {
                              return {
                                'result': 'success'
                              }; // Web-App Data Exchange : send data
                            } else {
                              return {'result': 'failed'};
                            }
                          });

                      webViewController = controller;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
