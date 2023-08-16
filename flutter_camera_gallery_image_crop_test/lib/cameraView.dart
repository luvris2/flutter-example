import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  // Image Picker 인스턴스 생성
  final ImagePicker picker = ImagePicker();

  // 카메라 또는 갤러리의 이미지를 저장할 변수
  XFile? _imageFile;

  // 자르거나 회전한 이미지를 저장할 변수
  CroppedFile? _croppedFile;

  // 이미지를 가져오는 함수
  Future<void> getImage(ImageSource imageSource) async {
    try {
      // 카메라 또는 갤러리의 이미지
      final XFile? imageFile = await picker.pickImage(source: imageSource);

      if (imageFile != null) {
        _imageFile = imageFile;
        // 가져온 이미지를 자르거나 회전하기 위한 함수 호출
        cropImage();
      }
    } catch (e) {
      print("디버깅용 이미지 호출 에러 : $e");
    }
  }

  // 이미지를 자르거나 회전하는 함수
  Future<void> cropImage() async {
    if (_imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile!.path, // 사용할 이미지 경로
        compressFormat: ImageCompressFormat.jpg, // 저장할 이미지 확장자(jpg/png)
        compressQuality: 100, // 저장할 이미지의 퀄리티
        uiSettings: [
          // 안드로이드 UI 설정
          AndroidUiSettings(
              toolbarTitle: '이미지 자르기/회전하기', // 타이틀바 제목
              toolbarColor: Colors.deepOrange, // 타이틀바 배경색
              toolbarWidgetColor: Colors.white, // 타이틀바 단추색
              initAspectRatio:
                  CropAspectRatioPreset.original, // 이미지 크로퍼 시작 시 원하는 가로 세로 비율
              lockAspectRatio: false), // 고정 값으로 자르기 (기본값 : 사용안함)
          // iOS UI 설정
          IOSUiSettings(
            title: '이미지 자르기/회전하기', // 보기 컨트롤러의 맨 위에 나타나는 제목
          ),
          // Web UI 설정
          WebUiSettings(
            context: context, // 현재 빌드 컨텍스트
            presentStyle: CropperPresentStyle.dialog, // 대화 상자 스타일
            boundary: // 크로퍼의 외부 컨테이너 (기본값 : 폭 500, 높이 500)
                const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort: // 이미지가 보이는 부분 (기본값 : 폭 400, 높이 400, 유형 사각형)
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true, // 디지털 카메라 이미지 파일 확장자 사용
            enableZoom: true, // 확대/축소 기능 활성화 (기본값 : false)
            showZoomer: true, // 확대/축소 슬라이더 표시/숨김 (기본값 : true)
          ),
        ],
      );

      if (croppedFile != null) {
        // 자르거나 회전한 이미지를 앱에 출력하기 위해 앱의 상태 변경
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 100,
                child: _buildPhotoArea(), // 이미지 표시 영역 위젯
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 카메라 선택 버튼
                  ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    child: const Text("카메라"),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  // 앨범 선택 버튼
                  ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: const Text("앨범"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // 카메라 혹은 갤러리의 이미지를 표현해주는 영역
  Widget _buildPhotoArea() {
    // 불러온 이미지가 있는지 없는지 확인
    return _imageFile != null
        // 불러온 이미지가 있으면 출력
        ? Center(
            child: Image.file(
              File(_croppedFile!.path),
            ),
          )
        // 불러온 이미지가 없으면 텍스트 출력
        : const Center(
            child: Text("불러온 이미지가 없습니다."),
          );
  }
}
