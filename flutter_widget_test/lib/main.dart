import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello_flutter', // 앱의 아이콘 이름
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true, // 앱 상단바 텍스트 중앙 정렬
          title: Text('Hello World Example'), // 앱 상단바 설정
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
              top: 100,
            ),
            child: Column(
              children: [
                Image.network(
                    'https://static.wikia.nocookie.net/pokemon/images/a/aa/%EC%82%90_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest/scale-to-width-down/200?cb=20170406071411&path-prefix=ko'),
                Center(
                  child: Text(
                    'Hello, World!!!',
                    style: TextStyle(
                      fontSize: 30, // 폰트 크기
                      fontWeight: FontWeight.bold, // 폰트 두께
                      color: Color.fromRGBO(255, 0, 0, 1), // 출력할 내용
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '입력한 글자는 그대로 보입니다.',
                    labelText: '텍스트필드1',
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '입력한 글자는 암호화 됩니다.',
                    labelText: '텍스트필드2',
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Elevated Button'),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Text Button'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('OutlinedButton'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
