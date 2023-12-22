import 'package:flutter/material.dart';

class BodyPage extends StatefulWidget {
  /* 생성자 초기화 */
  final int value; // 상태값

  const BodyPage({
    super.key,
    required this.value,
  });

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  int _bodyValue = 0; // 상태값을 저장할 변수 선언 및 초기화

  @override
  Widget build(BuildContext context) {
    // 생성자로 넘겨받은 상태값 저장, 상태값이 setState되면 리빌드되어 값 업데이트
    _bodyValue = widget.value;

    return Center(
      child: Text(
        _bodyValue.toString(), // 상태값 보여주기
        style: const TextStyle(
          fontSize: 20, // 폰트 크기 20
          fontWeight: FontWeight.bold, // 굵게
        ),
      ),
    );
  }
}
