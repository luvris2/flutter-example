import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WindowPopup extends StatefulWidget {
  // 메인 웹뷰에서 보낸 createWindowAction 값 저장 변수
  final CreateWindowAction createWindowAction;

  // 생성자 초기화
  const WindowPopup({Key? key, required this.createWindowAction})
      : super(key: key);

  @override
  State<WindowPopup> createState() => _WindowPopupState();
}

class _WindowPopupState extends State<WindowPopup> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // 팝업 표시를 위한 웹뷰 설정
            InAppWebView(
              // 메인 웹뷰에서 받은 windowId
              windowId: widget.createWindowAction.windowId,
              // 팝업 닫기 기능 구현
              onCloseWindow: (controller) {
                Navigator.pop(context);
              },
            ),
            // X 모양 아이콘 터치 시 팝업 닫기
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
