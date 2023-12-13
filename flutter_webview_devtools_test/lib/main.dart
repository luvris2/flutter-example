import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: WebviewPage(),
      ),
    ),
  );
}

class WebviewPage extends StatelessWidget {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // 웹뷰
      child: InAppWebView(
        // 초기 페이지 구성
        initialData: InAppWebViewInitialData(
          data: """
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InAppWebView Initial Page</title>
    <script>
        function sum() {
            let a = 1;
            let b = 2;
            let c = a+b;
            alert(a+"와 "+b+"의 값은 "+c+"입니다.");
        }
    </script>
</head>
<body>
    <center style="font-size:30pt;"> Hello World!
    <p>
    <input type="button" value="sum 함수 호출" onclick="sum()">
</body>
</html>
""",
        ),
      ),
    );
  }
}
