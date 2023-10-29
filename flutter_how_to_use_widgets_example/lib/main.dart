import 'package:flutter/material.dart';
import 'package:flutter_how_to_use_widgets_example/dropDownWidgets.dart';
import 'package:flutter_how_to_use_widgets_example/textEditingController.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget customButton(context, textContent, page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(textContent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customButton(context, '드롭다운 위젯 예제', const DropDownPage()),
          customButton(context, '텍스트에디팅컨트롤러 예제', const TextControllerPage()),
        ],
      ),
    );
  }
}
