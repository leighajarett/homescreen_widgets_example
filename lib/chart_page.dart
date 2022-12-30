import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final _globalKey = GlobalKey();
  Uint8List? pngBytes;
  static const platform =
      MethodChannel('example.widget.dev/get_container_path');
  static const String fileName = 'screenshot.png';
  String? imagePath;

  Future<void> _saveScreenShot() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.0); // image quality
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      await convertImageToFileAndSave(pngBytes!);
    } catch (e) {
      debugPrint('_saveScreenShot: $e');
    }
  }

  Future<void> convertImageToFileAndSave(Uint8List image) async {
    try {
      // Get path to directory where image will be saved from device
      final String path = await platform
          .invokeMethod('getContainerPath', {'appGroup': 'group.leighawidget'});
      // create a file and write it to the device at given location
      final file = File('$path/$fileName');
      await file.writeAsBytes(image);
    } on PlatformException catch (e) {
      debugPrint("convertImageToFile: $e");
    }
  }

  void _updateImageForWidget() {
    try {
      HomeWidget.saveWidgetData<String>('filename', fileName);
      HomeWidget.updateWidget(
        name: 'NewsWidget',
        androidName: 'NewsWidget',
        iOSName: 'NewsWidgets',
      );
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            Center(
              child: RepaintBoundary(
                key: _globalKey,
                child: CustomPaint(
                  painter: LineChartPainter(),
                  child: const SizedBox(
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: CupertinoButton.filled(
                child: const Text("save screenshot"),
                onPressed: () {
                  _saveScreenShot();
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: CupertinoButton.filled(
                child: const Text("update homescreen widget image"),
                onPressed: () {
                  _updateImageForWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dataPaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final mockDataPoints = [
      const Offset(40, 50),
      const Offset(60, 100),
      const Offset(80, 120),
      const Offset(100, 150),
      const Offset(120, 160),
      const Offset(140, 180),
      const Offset(160, 160),
      const Offset(180, 170),
    ];

    final axis = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);

    final data = Path()..moveTo(20, 20);

    for (var dataPoint in mockDataPoints) {
      data.lineTo(dataPoint.dx, dataPoint.dy);
    }

    canvas.drawPath(axis, axisPaint);
    canvas.drawPath(data, dataPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
