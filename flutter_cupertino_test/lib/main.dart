import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cupertino Demo',
      home: CupertinoExample(),
    );
  }
}

class CupertinoExample extends StatefulWidget {
  const CupertinoExample({super.key});

  @override
  State<CupertinoExample> createState() => _CupertinoState();
}

class _CupertinoState extends State<CupertinoExample> {
  // 쿠퍼티노 스위치 토글을 위한 값
  bool switchValue = true;

  // 쿠퍼티노 다이얼로그
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('알림'),
        content: const Text('쿠퍼티노 다이얼로그 내용'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            // isDefaultAction
            // 작업의 기본 값
            // 텍스트 색상을 파란색으로, 굵게 표시
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            // isDestructiveAction
            // 작업 수행, 삭제 및 전환과 같은 파괴적인 작업
            // 텍스트 색상을 빨간색으로 지정
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        // 쿠퍼티노 내비게이션 바 (앱 바)
        appBar: CupertinoNavigationBar(
          middle: const Text('Title'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.question_circle_fill,
                  size: 30,
                ),
                onPressed: () {
                  // 액션 버튼이 눌렸을 때 실행될 코드
                  // 쿠퍼티노 다이얼로그 호출
                  _showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // 배경이 채워진 쿠퍼티노 버튼
                  CupertinoButton.filled(
                    child: const Text('Press me!'),
                    onPressed: () {},
                  ),
                  // 배경이 채워지지 않은 쿠퍼티노 버튼
                  CupertinoButton(
                    child: const Text('Press me!'),
                    onPressed: () {},
                  ),
                  // 배경이 채워진 쿠퍼티노 비활성 버튼
                  const CupertinoButton.filled(
                    onPressed: null,
                    child: Text('Press me!'),
                  ),
                  // 배경이 채워지지 않은 쿠퍼티노 비활성 버튼
                  const CupertinoButton(
                    onPressed: null,
                    child: Text('Press me!'),
                  ),
                  // 쿠퍼티노 텍스트 필드
                  CupertinoTextField(
                    placeholder: 'Enter text',
                    onChanged: (text) {
                      // 입력 값이 변경될 때 실행될 코드
                    },
                  ),
                  // 쿠퍼티노 스위치
                  CupertinoSwitch(
                    // 부울 값으로 스위치 토글 (value)
                    value: switchValue,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (bool? value) {
                      // 스위치가 토글될 때 실행될 코드
                      setState(() {
                        switchValue = value ?? false;
                      });
                    },
                  ),
                  // 쿠퍼티노 액티비티 인디캐이터
                  const CupertinoActivityIndicator(
                      radius: 20.0, color: CupertinoColors.activeBlue),
                  const SizedBox(height: 10),
                  const Text(
                    'radius: 20.0\ncolor: CupertinoColors.activeBlue',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        // 쿠퍼티노 탭 바(바텀 내비게이션 바)
        bottomNavigationBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.star_fill),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock_solid),
              label: 'Recents',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle_fill),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.circle_grid_3x3_fill),
              label: 'Keypad',
            ),
          ],
        ),
      ),
    );
  }
}
