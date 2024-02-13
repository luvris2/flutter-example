import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: RadarChartTest(),
      ),
    ),
  );
}

class RadarChartTest extends StatefulWidget {
  const RadarChartTest({super.key});

  @override
  State<RadarChartTest> createState() => _RadarChartTestState();
}

class _RadarChartTestState extends State<RadarChartTest> {
/* 파라미터 정의 예시 */

// 축 표시 간격
  var ticks = [7, 14, 21, 28, 35];

// 각각의 데이터 이름
  var features = ["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH"];

// 각 데이터 이름의 세부 수치
  var data = [
    [10.0, 20, 28, 5, 16, 15, 17, 6],
    [14.5, 1, 4, 14, 23, 10, 6, 19]
  ];

  @override
  Widget build(BuildContext context) {
    /* 휴대폰 낮/밤 모드에 따라 차트 설정 가능
    * 라이트 모드 : RadarChart.light 사용
    *	- 라이트 모드일 경우, 차트 색상의 기본색은 검은색
    * 다크 모드 : RadarChart.dark 사용
    *	- 다크 모드일 경우, 차트 색상의 기본색은 흰색
    * 예시) 라이트 모드로 레이더 차트 그리기
    **************************************
    * RadarChart.light(
    *    ticks: ticks,
    *    features: features,
    *    data: data,
    * ),
    **************************************
    */
    return Container(
      color: Colors.white,
      child: RadarChart(
        ticks: ticks, // 차트 축 간격
        features: features, // 각각의 데이터 이름
        data: data, // 각 데이터 이름의 세부 수치
        // 데이터 표시 범위 색상 변경 : 리스트 타입으로 색상을 나열
        graphColors: const [
          Colors.red, // 첫 번째 피처 데이터는 빨간색으로 표시
          Colors.yellow, // 두 번째 피처 데이터는 노란색으로 표시
        ],
        axisColor: Colors.green, // 축 색상 변경
        outlineColor: Colors.blue, // 차트 테두리 색상 변경
        // 축 표시 글꼴 색상 변경
        ticksTextStyle: const TextStyle(color: Colors.green, fontSize: 16),
        // 피처 표시 글꼴 색상 변경
        featuresTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        // 축 표시 값 반전 : 기본값 false
        reverseAxis: false,
        // 다각형 설정
        sides: 8,
      ),
    );
  }
}
