import 'package:flutter/material.dart';
import 'package:flutter_dialog_test/stateful_dialog.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          // showDialog 샘플
          child: MainPage(),
          // showDialog 내에서 setState 샘플
          // child: MainPage2(),
        ),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 카운팅 값을 저장하는 변수
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Center(
          child: Column(
        children: [
          // 카운팅된 값을 표시하는 영역
          Text('값 : ${value.toString()}'),
          ElevatedButton(
            // 버튼 터치 시 다이얼로그 함수 호출
            onPressed: () {
              // 정의한 다이얼로그 함수
              _dialogBuilder(context);
            },
            child: const Text('다이얼로그 출력'),
          ),
        ],
      )),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    // 현재 화면 위에 보여줄 다이얼로그 생성
    return showDialog<void>(
      context: context,
      builder: (context) {
        // 빌더로 AlertDialog 위젯을 생성
        return AlertDialog(
          title: const Text('다이얼로그 제목'),
          content: const Text('다이얼로그 내용'),
          actions: [
            ElevatedButton(
              // 다이얼로그 내의 확인 버튼 터치 시 값 +1
              onPressed: () {
                setState(() => value++);
              },
              child: const Text('확인'),
            ),
            // 다이얼로그 내의 취소 버튼 터치 시 다이얼로그 화면 제거
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }
}
