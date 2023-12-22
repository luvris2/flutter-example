import 'package:class_parameter_value_exchange/body.dart';
import 'package:class_parameter_value_exchange/fab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 상태 값
  int _currentValue = 0;

  // 상태를 관리하는 함수
  void setValue(int value) {
    setState(() {
      _currentValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /* 통합 상태 관리를 위해 각각의 페이지에 상태값과 상태변환 함수를 넘겨줌 */
        // 메인 페이지
        body: BodyPage(
          value: _currentValue, // 상태값
        ),
        // 플로팅 액션 바 페이지
        floatingActionButton: FloatingActionButtonPage(
          value: _currentValue, // 상태값
          setValue: setValue, // 상태 업데이트 함수
        ),
      ),
    );
  }
}
