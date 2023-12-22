import 'package:flutter/material.dart';

class FloatingActionButtonPage extends StatelessWidget {
  /* 생성자 초기화 */
  final int value; // 상태값
  final Function(int) setValue; // 상태 변환 함수

  const FloatingActionButtonPage({
    super.key,
    required this.value,
    required this.setValue,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Text("+1"),
      onPressed: () {
        // FAB 버튼 터치 시 값 + 1 카운팅
        setValue(value + 1);
      },
    );
  }
}
