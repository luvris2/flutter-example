import 'package:flutter/material.dart';

class TextControllerPage extends StatefulWidget {
  const TextControllerPage({super.key});

  @override
  State<TextControllerPage> createState() => _TextControllerPageState();
}

class _TextControllerPageState extends State<TextControllerPage> {
  // 텍스트 컨트롤러 생성
  TextEditingController textController = TextEditingController();

  // 사용자가 입력한 텍스트를 저장하기 위한 문자열 변수
  String textContent = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 텍스트필드 위젯
              _buildArea(),
              // 사용자가 입력한 값 보여주기
              Text("텍스트필드의 입력 값 : $textContent"),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildArea() {
    return TextField(
        // 컨트롤러 연결
        controller: textController,
        // 텍스트 입력 시 중앙 정렬
        textAlign: TextAlign.center,
        // 입력한 값 문자열 변수에 업데이트
        onChanged: (value) {
          setState(() => textContent = textController.text);
        });
  }
}
