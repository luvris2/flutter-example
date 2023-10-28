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
  String language = "fr-FR";
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

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildMain());
  }

  Widget _buildMain() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
            child: const Text('sdf'))
      ],
    );
  }
}
