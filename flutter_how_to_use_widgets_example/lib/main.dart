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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DropDownPage()));
            },
            child: const Text('드롭다운 위젯 예제'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TextControllerPage()));
            },
            child: const Text('텍스트에디팅컨트롤러 예제'),
          ),
        ],
      ),
    );
  }
}
