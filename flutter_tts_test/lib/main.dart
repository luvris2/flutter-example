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

  /* 음성 설정
    한국어 여성 {"name": "ko-kr-x-ism-local", "locale": "ko-KR"}
	  영어 여성 {"name": "en-us-x-tpf-local", "locale": "en-US"}
    일본어 여성 {"name": "ja-JP-language", "locale": "ja-JP"}
    중국어 여성 {"name": "cmn-cn-x-ccc-local", "locale": "zh-CN"}
    중국어 남성 {"name": "cmn-cn-x-ccd-local", "locale": "zh-CN"}
*/
  Map<String, String> voice = {"name": "ko-kr-x-ism-local", "locale": "ko-KR"};
  String engine = "com.google.android.tts";
  double volume = 0.8;
  double pitch = 1.0;
  double rate = 0.5;

  // 사용자의 입력 값을 받을 컨트롤러
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // TTS 초기 설정
    initTts();
  }

  // TTS 초기 설정
  initTts() async {
    await initTtsIosOnly(); // iOS 설정

    flutterTts.setLanguage(language);
    flutterTts.setVoice(voice);
    flutterTts.setEngine(engine);
    flutterTts.setVolume(volume);
    flutterTts.setPitch(pitch);
    flutterTts.setSpeechRate(rate);
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

  // TTS로 읽어주기
  Future _speak(voiceText) async {
    flutterTts.speak(voiceText);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
              onPressed: () {
                _speak(textEditingController.text);
              },
              child: const Text('내용 읽기')),
        ],
      ),
    );
  }
}
