import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 뒤로가기 버튼의 누른 시간을 저장하기 위한 변수
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    // 위젯을 감싸서 WillPop을 통해 뒤로가기 버튼 정의
    return WillPopScope(
      // 뒤로가기 버튼을 누를 경우의 이벤트 정의
      onWillPop: () async {
        // 콘솔에 메시지 출력
        //printMsg();

        // 뒤로가기 버튼 누를 경우 앱 종료 확인 다이얼로그 출력
        onBackPressed(context);

        // 뒤로가기 버튼 두 번 누를 경우 앱 종료
        // if (await onBackDoublePressed(context)) {
        //   return true;
        // }

        // 뒤로가기 버튼 기본 기능 무력화
        return false;
      },
      // 감쌀 위젯 정의
      child: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }

  // onWillPop 콜백 함수에서 콘솔에 메시지를 출력하는 함수
  void printMsg() {
    print('WillPopCallback : Hello World!');
  }

  // 뒤로가기 버튼 누를 경우 종료 다이얼로그 출력 함수
  Future<void> onBackPressed(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('앱을 종료하시겠습니까?')),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 취소 버튼
              ElevatedButton(
                child: const Text('취소'),
                onPressed: () => Navigator.pop(context),
              ),
              // 종료 버튼
              ElevatedButton(
                child: const Text('확인'),
                onPressed: () => SystemNavigator.pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 뒤로가기 버튼 두 번 누를 경우 앱 종료 함수
  Future<bool> onBackDoublePressed(BuildContext context) async {
    // 현재 시간 확인
    DateTime now = DateTime.now();

    // 뒤로가기 두 번 누를 경우의 종료 이벤트 정의
    // currentBackPressTime : 뒤로가기 버튼을 누른 시간을 저장하고 2초 내에 다시 버튼이 눌리는지 확인하기 위한 변수
    // 2초 후 뒤로가기 버튼 눌림 : if를 통한 반환값 : false (종료하지 않음)
    // 2초 내 뒤로가기 버튼 눌림 : if를 통한 반환값 : true (앱 종료)
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.notification_important,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '뒤로가기 버튼을 한 번 더 누르시면 종료됩니다.',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
      // 처음 뒤로가기 버튼을 눌렀거나 2초 이후에 누를 경우 : false
      return Future.value(false);
    }
    // 2초 이내에 뒤로가기 버튼을 또 눌럿을 경우 : true
    return Future.value(true);
  }
}
