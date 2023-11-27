import 'package:flutter/material.dart';

class MainPage2 extends StatefulWidget {
  const MainPage2({super.key});

  @override
  State<MainPage2> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage2> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _dialogBuilder();
            },
            child: const Text('StatefulBuilder 다이얼로그'),
          ),
          ElevatedButton(
            onPressed: () {
              _dialogStfWidget();
            },
            child: const Text('StatefullWidget 다이얼로그'),
          ),
        ],
      )),
    );
  }

  Future<void> _dialogBuilder() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('StatefulBuilder 활용'),
            content: Text('다이얼로그 내에서 값 변경하기 : $value'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() => value++);
                },
                child: const Text('확인'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('취소'),
              ),
            ],
          );
        });
      },
    );
  }

  Future<dynamic> _dialogStfWidget() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const DialogPage();
      },
    );
  }
}

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('StatefulWidget 활용'),
      content: Text('다이얼로그 내에서 값 변경하기 : $value'),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() => value++);
          },
          child: const Text('확인'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
      ],
    );
  }
}
