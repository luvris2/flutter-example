import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({super.key});

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  // 드롭다운 버튼의 선택된 값을 저장할 변수
  String dropDownValue = "1";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 드롭다운 위젯
              _buildArea(),
              // 선택한 값 보여주기
              Text("드롭다운 버튼에서 '$dropDownValue'을(를) 선택하셨습니다."),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildArea() {
    // 드롭다운 리스트
    List<String> dropDownList = ['1', '2', '3'];

    // 초기값 설정
    if (dropDownValue == "") {
      dropDownValue = dropDownList.first;
    }

    return DropdownButton(
      // 드롭다운 버튼에 처음 보여질 값
      value: dropDownValue,
      // 드롭다운의 리스트를 보여줄 값
      items: dropDownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      /* 아래와 같은 방법으로도 정의 할 수 있음 */
      // items: const [
      //   DropdownMenuItem(
      //     value: '1',
      //     child: Text('1'),
      //   ),
      //   DropdownMenuItem(
      //     value: '2',
      //     child: Text('2'),
      //   ),
      //   DropdownMenuItem(
      //     value: '3',
      //     child: Text('3'),
      //   ),
      // ],
      // 드롭다운의 값을 선택했을 경우
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
          print(dropDownValue);
        });
      },
    );
  }
}
