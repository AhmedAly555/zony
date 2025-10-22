import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../views/widgets/template_app_scaffold.widget.dart';

class CustomCameraScreen extends StatefulWidget {
  /// Callback بيرجع الصورة بعد التصوير
  final void Function(File image)? onPictureTaken;

  /// Callback عند الضغط على زر الرجوع
  final VoidCallback? onBack;

  const CustomCameraScreen({
    super.key,
    this.onPictureTaken,
    this.onBack,
  });

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller!.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final XFile file = await _controller!.takePicture();

      /// هنا بستدعي الـ callback بدل ما أربط بلوجيك ثابت
      if (widget.onPictureTaken != null) {
        widget.onPictureTaken!(File(file.path));
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: _controller == null
          ?  Center(child: LoadingAnimationWidget.threeArchedCircle(
        color: Color(0xFF49159B),
        size: 50,
      ),)
          : FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_controller!),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24, left: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.onBack != null) {
                          widget.onBack!();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 14,
                        ),
                        child: SvgPicture.asset(
                          'assets/svgs/arrow_back.svg',
                          width: 10,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ElevatedButton(
                      onPressed: _takePicture,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF49159B),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(34),
                      ),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// How to use it?
/*
  ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomCameraScreen(
          onPictureTaken: (File image) {
            // هنا اللوجيك بتاعك بعد التصوير
            // مثلا: ترفع الصورة للسيرفر أو تعرضها في شاشة جديدة
            print("الصورة اتاخدت: ${image.path}");

            // لو عايز ترجع الصورة للشاشة اللي فتحت الكاميرا:
            Navigator.pop(context, image);
          },
          onBack: () {
            // لوجيك للرجوع (اختياري)
            Navigator.pop(context);
          },
        ),
      ),
    ).then((result) {
      if (result != null && result is File) {
        // هنا تستقبل الصورة لو رجعتها من الكاميرا
        print("رجعت بالصورة: ${result.path}");
      }
    });
  },
  child: Text("افتح الكاميرا"),
),
 */