import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: NavigatorMain(),
    ),
  ));
}

class NavigatorMain extends StatefulWidget {
  const NavigatorMain({super.key});

  @override
  State<NavigatorMain> createState() => _NavigatorMainState();
}

class _NavigatorMainState extends State<NavigatorMain> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 값 표시
            Text(value.toString()),
            // 세컨드 페이지로 이동, 값 전달
            ElevatedButton(
              onPressed: () async {
                final returnValue = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigatorSecond(value: value),
                  ),
                );
                // 세컨드 페이지에서 전달 받은 값 업데이트
                setState(() {
                  value = returnValue;
                });
              },
              child: const Text('Second Page로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigatorSecond extends StatefulWidget {
  // 생성자로 넘겨받은 값 초기화
  final int value;
  const NavigatorSecond({super.key, required this.value});

  @override
  State<NavigatorSecond> createState() => _NavigatorSecondState();
}

class _NavigatorSecondState extends State<NavigatorSecond> {
  int returnValue = 0;

  // 생성자의 값 저장
  @override
  void initState() {
    super.initState();
    returnValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 값 표시
            Text(returnValue.toString()),
            ElevatedButton(
              onPressed: () {
                // 버튼 터치 시 값을 이전 페이지로 전달하며 Pop
                Navigator.pop(context, returnValue);
              },
              child: const Text('Main Page로 이동'),
            ),
            // 버튼 터치 시 값 + 1 증가
            ElevatedButton(
              onPressed: () {
                setState(() {
                  returnValue += 1;
                });
              },
              child: const Text('+1'),
            ),
          ],
        ),
      ),
    );
  }
}
