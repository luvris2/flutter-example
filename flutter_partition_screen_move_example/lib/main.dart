import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: MainPage()),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header
        Container(color: Colors.red, height: 100),
        // body
        const Expanded(child: BodyPage()),
        // foot
        Container(color: Colors.green, height: 100),
      ],
    );
  }
}

class BodyPage extends StatefulWidget {
  const BodyPage({super.key});

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  Widget bodyPage = Container(color: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bodyPage,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => setState(() => bodyPage = const Page1()),
                    child: const Text("페이지1 이동")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: ElevatedButton(
                      onPressed: () => setState(() => bodyPage = const Page2()),
                      child: const Text("페이지2 이동")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.deepPurple);
  }
}
