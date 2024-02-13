import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: MainPage(),
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
  // 색상 초기값 정의
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;

  // 색상 변경 함수
  changeColor(color) {
    setState(() => pickerColor = color);
  }

  // 컬러피커 호출 함수
  selectColor(type) {
    // 선택한 컬러피커 종류 확인
    Widget pickerType;
    if (type == 'ColorPicker') {
      pickerType = ColorPicker(
        pickerColor: pickerColor,
        onColorChanged: changeColor,
      );
    } else if (type == 'MaterialPicker') {
      pickerType = MaterialPicker(
        pickerColor: pickerColor,
        onColorChanged: changeColor,
      );
    } else {
      pickerType = BlockPicker(
        pickerColor: pickerColor,
        onColorChanged: changeColor,
      );
    }

    // 컬러피커 다이얼로그 호출
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('색상을 선택하세요.'),
          content: SingleChildScrollView(
            child: pickerType,
          ),
          actions: <Widget>[
            // 버튼 터치 시 선택한 색상으로 업데이트
            ElevatedButton(
              child: const Text('색 선택'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('선택한 색상'),
          // 사용자가 선택한 색상을 표시하는 컨테이너
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            decoration: BoxDecoration(
              color: currentColor,
              border: Border.all(color: Colors.black),
            ),
          ),
          const Text('색상 변경하기'),
          /* [버튼 기능 정의]
          * 버튼을 누르면 selectColor 함수 호출
          * 버튼별 컬러피커 종류를 함수의 파라미터로 전달
          */
          ElevatedButton(
            onPressed: (() => selectColor('ColorPicker')),
            child: const Text('ColorPicker'),
          ),
          ElevatedButton(
            onPressed: (() => selectColor('MaterialPicker')),
            child: const Text('MaterialPicker'),
          ),
          ElevatedButton(
            onPressed: (() => selectColor('BlockPicker')),
            child: const Text('BlockPicker'),
          )
        ],
      ),
    );
  }
}
