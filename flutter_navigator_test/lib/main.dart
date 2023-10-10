import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyMain(),
        '/secondPage': (context) => const SecondPage(index: 0),
      },
    ),
  );
}

class MyMain extends StatelessWidget {
  const MyMain({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('MainPage'),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(index: 0),
                  ),
                );
              },
              child: const Text('push')),
        ],
      )),
    );
  }
}

class SecondPage extends StatefulWidget {
  final int index;
  const SecondPage({super.key, required this.index});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    _index += widget.index + 1;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page Stack : $_index',
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              child: const Text('push'),
              onPressed: () {
                // push : 현재 화면 위에 페이지를 표시
                // 현재 화면을 두고 스택을 추가하여 표시
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(index: _index),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('pop'),
              onPressed: () {
                // pop : 현재 페이지를 화면에서 제거
                // 스택에서 이전 페이지로 이동
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('popUntil'),
              onPressed: () {
                // popUntil : 지정된 조건이 만족하는 페이지까지 이전 화면으로 이동
                // 특정 페이지까지의 이전 페이지들의 스택을 모두 제거
                Navigator.popUntil(
                    context, (route) => route.isFirst); // 첫번째 페이지까지 이전 페이지로 이동
              },
            ),
            ElevatedButton(
              child: const Text('pushReplacement'),
              onPressed: () {
                // pushReplacement : 현재 화면을 새로운 화면으로 교체
                // 이전 화면을 스택에서 제거하고 현재 화면을 스택에 추가
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(index: _index),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('pushNamed'),
              onPressed: () {
                // pushNamed : 현재 화면 위에 지정한 루트 이름의 페이지를 표시
                // 지정된 루트 이름으로 새로운 화면을 스택에 추가
                Navigator.pushNamed(context, '/home');
              },
            ),
            // ElevatedButton(
            //   child: const Text('pushNamedAndRemoveUntil'),
            //   onPressed: () {
            //     // pushNamedAndRemoveUntil : 현재 페이지를 지정된 루트 이름의 페이지 화면으로 교체 후 이전 페이지의 스택 제거
            //     // 지정된 루트 이름으로 새로운 화면을 스택에 추가하고
            //     // 지정된 조건이 충족될 때까지 다른 화면을 제거
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, '/MainPage', (route) => route.isFirst);
            //   },
            // ),
            // ElevatedButton(
            //   child: const Text('pushReplacementNamed'),
            //   onPressed: () {
            //     // pushReplacementNamed : 현재 화면을 지정된 루트 이름의 페이지 화면으로 교체
            //     // 현재 화면을 제거하고 지정된 루트 이름으로 새로운 화면을 스택에 추가
            //     Navigator.pushReplacementNamed(context, '/MainPage');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
