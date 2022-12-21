import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:homescreen_widgets/newsData.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late newsArticle headline;
  final _globalKey = GlobalKey();
  Uint8List? pngBytes;
  static const platform =
      MethodChannel('example.widget.dev/get_container_path');
  String? image_path;

  void initState() {
    super.initState();
    // Set the group ID
    HomeWidget.setAppGroupId('group.leighawidget');
    // Mock read in some data and update the headline
    updateHeadline(getNewsStories()[0]);
  }

  void updateHeadline(newsArticle newHeadline) {
    setState(() {
      headline = newHeadline;
      // Save the headline data to the widget
      HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
      HomeWidget.saveWidgetData<String>(
          'headline_description', newHeadline.description);
      HomeWidget.updateWidget(iOSName: 'NewsWidgets');
      print('updated headline');
    });
  }

  Future<File?> convertImageToFile(Uint8List image) async {
    final file_name = 'screenshot.png';
    try {
      final String path = await platform
          .invokeMethod('getContainerPath', {'appGroup': 'group.leighawidget'});
      final file = File('${path}/${file_name}');
      await file.writeAsBytes(image);

      HomeWidget.saveWidgetData<String>('filename', file_name);
      HomeWidget.updateWidget(iOSName: 'NewsWidgets');
      setState(() {
        image_path = file.path;
        print(image_path);
      });
      return file;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<void> _SaveScreenShot() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.0); // image quality
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      final file = await convertImageToFile(pngBytes!);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MY LOGO')),
        body: Center(
            child: Column(
          children: [
            Text(headline.title!),
            Text(headline.description!),
            CupertinoButton.filled(
                child: Text("update state"),
                onPressed: () {
                  updateHeadline(getNewsStories()[1]);
                }),
            CupertinoButton.filled(
                child: Text("save screenshot"),
                onPressed: () {
                  _SaveScreenShot();
                }),
            RepaintBoundary(
              key: _globalKey,
              child: CustomPaint(
                painter: LineChartPainter(),
                child: Container(
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ],
        )));
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
      Offset(40, 50),
      Offset(60, 100),
      Offset(80, 120),
      Offset(100, 150),
      Offset(120, 160),
      Offset(140, 180),
      Offset(160, 160),
      Offset(180, 170),
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
