import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController scrollController = ScrollController();
  List value = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainBody(),
      floatingActionButton: fab(),
    );
  }

  // 바디 영역
  Widget mainBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: value.length,
      itemBuilder: (context, index) {
        return listContainer(value[index], index);
      },
    );
  }

  // 바디 영역의 리스트 컨테이너
  Widget listContainer(value, index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 50),
      width: double.infinity,
      height: 200,
      color: Colors.amber[(index + 1) * 100],
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  // 플로팅 액션 버튼 구성
  Widget fab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        floatingActionButton("맨위로"),
        floatingActionButton("위로"),
        floatingActionButton("중간으로"),
        floatingActionButton("아래로"),
        floatingActionButton("맨아래로"),
        floatingActionButton("특정위치"),
      ],
    );
  }

  // 플로팅 액션 버튼 위젯
  Widget floatingActionButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
          onPressed: () {
            activeScroll(text);
          },
          child: Text(text)),
    );
  }

  // 플로팅 액션 버튼 기능 정의
  void activeScroll(text) {
    if (text == "맨위로") {
      moveScroll(0);
    } else if (text == "위로") {
      moveScroll(scrollController.offset - 300);
    } else if (text == "중간으로") {
      moveScroll(scrollController.position.maxScrollExtent / 2);
    } else if (text == "아래로") {
      moveScroll(scrollController.offset + 300);
    } else if (text == "맨아래로") {
      moveScroll(scrollController.position.maxScrollExtent);
    } else if (text == "특정위치") {
      moveScroll(150);
    }
  }

  // 스크롤 이동 기능 정의
  void moveScroll(value) {
    scrollController.animateTo(value.toDouble(),
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
