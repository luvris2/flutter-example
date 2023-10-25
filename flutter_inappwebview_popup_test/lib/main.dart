import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_inappwebview_popup_test/windowPopup.dart';

void main() {
  runApp(const MaterialApp(
      home: Scaffold(body: SafeArea(child: InAppWebViewPage()))));
}

class InAppWebViewPage extends StatelessWidget {
  const InAppWebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      // 팝업 허용을 위한 옵션 설정
      initialOptions: InAppWebViewGroupOptions(
        // 모든 플랫폼 공용 옵션
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true, // 자바스크립트 사용 여부
          javaScriptCanOpenWindowsAutomatically: true, // 팝업 여부
        ),
        // 안드로이드 플랫폼 옵션
        android: AndroidInAppWebViewOptions(
          supportMultipleWindows: true, // 멀티 윈도우 허용
        ),
      ),
      initialData: InAppWebViewInitialData(data: """
        <!DOCTYPE html>
        <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Popup Test</title>
            <script>
                function doOpen() { window.open('https://luvris2.tistory.com'); }
            </script>
        </head>
        <body>
            <center>
            <input type=button value="팝업 띄우기" onclick=doOpen() style="width:200px;height:200px;font-size: xx-large;">
        </body>
        </html>
      """),
      onCreateWindow: (controller, createWindowAction) async {
        // 팝업을 띄울 때의 제어 코드 작성
        showDialog(
          context: context,
          builder: (context) =>
              WindowPopup(createWindowAction: createWindowAction),
        );
        return true;
      },
    );
  }
}
