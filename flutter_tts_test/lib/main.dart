import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SafeArea(child: MyTts()),
    ),
  ));
}

class MyTts extends StatefulWidget {
  const MyTts({super.key});

  @override
  State<MyTts> createState() => _MyTtsState();
}

class _MyTtsState extends State<MyTts> {
  FlutterTts flutterTts = FlutterTts();
  /* 언어 설정
    한국어    =   "ko-KR"
    일본어    =   "ja-JP"
    영어      =   "en-US"
    중국어    =   "zh-CN"
    프랑스어  =   "fr-FR"
  */
  String language = "ko-KR";
  //String engine = ;
  double volume = 3.0;
  double pitch = 1.4;
  double rate = 0.3;

  final TextEditingController textEditingController = TextEditingController();

  bool isToggled = false;

  @override
  void initState() {
    super.initState();

    initTts();
  }

  initTts() async {
    await initTtsIosOnly(); // iOS 설정

    flutterTts.setLanguage(language);
    flutterTts.setPitch(pitch);
    flutterTts.setSpeechRate(rate);
    flutterTts.setVolume(volume);

    //flutterTts.setVoice({"name": "ko-KR-Neural2-C", "locale": "ko-KR"});
  }

  // TTS iOS 옵션
  Future<void> initTtsIosOnly() async {
    // iOS 전용 옵션 : 공유 오디오 인스턴스 설정
    await flutterTts.setSharedInstance(true);

    // 배경 음악와 인앱 오디오 세션을 동시에 사용
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);
  }

  Future _speak(voiceText) async {
    flutterTts.speak(voiceText);
  }

  Future<List<dynamic>> getTtsOptions() async {
    List<Object?> objVoices = await flutterTts.getVoices;
    List<String> ttsVoices = [];
    for (var item in objVoices) {
      if (item.toString().contains('ko')) {
        ttsVoices.add(item.toString());
      }
    }

    List<Object?> objLanguages = await flutterTts.getLanguages;
    List<String> ttsLanguages = [];
    for (var item in objLanguages) {
      if (item.toString().contains('ko')) {
        ttsLanguages.add(item.toString());
      }
    }

    return [ttsVoices, ttsLanguages];
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildMain());
  }

  Widget _buildMain() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TTS 옵션 선택 영역
        _ttsOptionArea(),

        TextField(
          controller: textEditingController,
        ),
        Container(height: 50),
        const Row(
          children: [
            //ToggleButtons(isSelected: isToggled, children: const Text('sdf'))
          ],
        ),
        ElevatedButton(
            onPressed: () {
              _speak(textEditingController.text);
            },
            child: const Text('sdf')),
        ElevatedButton(onPressed: () {}, child: const Text('getOptions'))
      ],
    );
  }

  // Widget _ttsOptionArea() {
  //   String selectedVoice = "name: ko-kr-x-ism-local, locale: ko-KR";
  //   String selectedLanguage = "";
  //   return FutureBuilder(
  //     future: getTtsOptions(),
  //     builder: ((context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // 데이터를 기다리는 동안 로딩 스피너나 다른 대기 UI를 표시할 수 있습니다.
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (snapshot.hasError) {
  //         // 에러 처리
  //         return Center(
  //           child: Text('Error: ${snapshot.error}'),
  //         );
  //       } else {
  //         // Future에서 얻은 데이터를 사용하여 화면을 빌드합니다.
  //         final List ttsData = snapshot.data!.toList();
  //         final List<String> ttsVoices = ttsData[0];
  //         final List<String> ttsEngines = ttsData[1];
  //         //final List<String> ttsLanguages = ttsData[2];

  //         return Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             const Text("TTS 옵션 선택"),
  //             DropdownButton(
  //                 value: ttsEngines,
  //                 items: ttsVoices.map<DropdownMenuItem<String>>((value) {
  //                   return DropdownMenuItem<String>(
  //                       value: value, child: Text(value));
  //                 }).toList(),
  //                 onChanged: (String value) {
  //                   setState(() {
  //                     selectedVoice = value;
  //                   });
  //                 }),
  //           ],
  //         );
  //       }
  //     }),
  //   );
  // }
}
