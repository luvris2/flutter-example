import 'package:flutter/material.dart';

void main() {
  runApp(const FocusPage());
}

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  final FocusNode _focusNode = FocusNode(); // 텍스트필드의 포커스노드
  final TextEditingController _textController =
      TextEditingController(); // 텍스트필드의 컨트롤러
  String notifyText = ""; // 텍스트필드 입력 관련 알림 메시지

  // 포커스 상태 확인 함수
  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      debugPrint('##### focus on #####');
    } else {
      debugPrint('##### focus off #####');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 포커스 상태 확인을 위한 리스너
    _focusNode.addListener(() => _handleFocusChange);

    return GestureDetector(
      // GestureDetector 위젯을 최상위로 감싸 터치 감지 후, 입력 관련 외 위젯을 터치하면 포커스 제거
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // 내용을 입력할 텍스트필드
                TextField(
                  focusNode: _focusNode,
                  controller: _textController,
                  decoration: const InputDecoration(labelText: '내용 입력'),
                ),
                // 입력 내용 관련 알림 메시지
                Text(notifyText, style: const TextStyle(color: Colors.red)),
                // 확인 버튼
                ElevatedButton(
                  onPressed: () {
                    // 텍스트필드에 입력 내용 확인
                    if (_textController.text == "") {
                      // 내용이 없으면 포커스를 텍스트필드로 이동하고 알림 메시지 출력
                      _focusNode.requestFocus();
                      setState(() => notifyText = "내용을 입력해주세요.");
                    } else {
                      setState(() => notifyText = "");
                    }
                  },
                  child: const Text("확인"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 포커스 노드 및 리스너 제거
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();

    super.dispose();
  }
}
