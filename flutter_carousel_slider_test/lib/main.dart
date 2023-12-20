import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(body: CarouselSliderPage()),
  ));
}

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({super.key});

  @override
  State<CarouselSliderPage> createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  final List<String> _list = [
    'assets/images/pi01.png',
    'assets/images/pi02.png'
  ];
  final CarouselController carouselController =
      CarouselController(); // 캐러셀 컨트롤러
  int currentIndex = 0; // 캐러셀 인디케이터 인덱스

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: double.infinity, // 최대 크기로 지정
            viewportFraction: 0.8, // 이미지 100% 비율로 보여줌
            autoPlay: true, // 자동 슬라이드 허용
            autoPlayInterval: const Duration(seconds: 5), // 5초마다 자동 슬라이드
            onPageChanged: ((index, reason) {
              // 페이지 슬라이드 시 인덱스 변경
              setState(() {
                currentIndex = index;
              });
            }),
          ),
          items: _list.map((String item) {
            return Image.asset(item,
                fit: BoxFit.contain); // 이미지를 화면에 맞게 조절, 가로 세로 비율 무시
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              // 리스트에 있는 값을 map 함수를 이용하여 MapEntry 객체 컬렉션으로 생성된 Iterable을 List로 변환
              _list.asMap().entries.map((entry) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // 인디케이터에서 선택한 페이지로 이동
                  carouselController.animateToPage(entry.key);
                },
                // 인디케이터에 표시될 위젯
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 45.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 133, 133, 133)
                          .withOpacity(currentIndex == entry.key
                              ? 0.9
                              : 0.4)), // 현재 인덱스일 경우 진하게 표시
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
