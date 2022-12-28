import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/news_data.dart';

import 'color_schemes.g.dart';

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
        colorScheme: lightColorScheme,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NewsArticle headline;
  final _globalKey = GlobalKey();
  Uint8List? pngBytes;
  static const platform =
      MethodChannel('example.widget.dev/get_container_path');
  String? imagePath;

  @override
  void initState() {
    super.initState();
    // Set the group ID
    HomeWidget.setAppGroupId('group.leighawidget');
    // Mock read in some data and update the headline
    updateHeadline(getNewsStories()[0]);
  }

  void updateHeadline(NewsArticle newHeadline) {
    setState(() {
      headline = newHeadline;
      // Save the headline data to the widget
      HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
      HomeWidget.saveWidgetData<String>(
          'headline_description', newHeadline.description);
      HomeWidget.updateWidget(iOSName: 'NewsWidgets');
    });
  }

  Future<File?> convertImageToFile(Uint8List image) async {
    const fileName = 'screenshot.png';
    try {
      final String path = await platform
          .invokeMethod('getContainerPath', {'appGroup': 'group.leighawidget'});
      final file = File('$path/$fileName');
      await file.writeAsBytes(image);

      HomeWidget.saveWidgetData<String>('filename', fileName);
      HomeWidget.updateWidget(iOSName: 'NewsWidgets');
      setState(() {
        imagePath = file.path;
        debugPrint(imagePath);
      });
      return file;
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }

    return null;
  }

  Future<void> _saveScreenShot() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.0); // image quality
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      // TODO: return file from following method call, then handle the widget update elsewhere. because this code will be seen and judged :)
      await convertImageToFile(pngBytes!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CupertinoButton.filled(
                child: const Text("update state"),
                onPressed: () {
                  updateHeadline(getNewsStories()[1]);
                }),
            CupertinoButton.filled(
                child: const Text("save screenshot"),
                onPressed: () {
                  _saveScreenShot();
                }),
            RepaintBoundary(
              key: _globalKey,
              child: CustomPaint(
                painter: LineChartPainter(),
                // TODO: use SizedBox?
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('images/FlutterForward_Logo_Dark_Gradient.png'),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              child: Row(
                children: [
                  Text(
                    'Top Stories',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineLarge!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, idx) {
                  return const Divider();
                },
                itemCount: getNewsStories().length,
                itemBuilder: (context, idx) {
                  final article = getNewsStories()[idx];
                  return ListTile(
                    key: Key("$idx ${article.hashCode}"),
                    title: Text(article.title!),
                    subtitle: Text(article.description!),
                    onTap: () {
                      _showArticlePage(context, article);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Use deep linking, if we want to add the feature of clicking on an article from the homescreen widget
  void _showArticlePage(BuildContext context, NewsArticle article) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Material(
          child: Scaffold(
            appBar: AppBar(
              title: Text(article.title!),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.image != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Image.asset('images/${article.image}'),
                      ),
                    ),
                  const SizedBox(height: 10.0),
                  Text(article.description!,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 20.0),
                  Text(article.articleText),
                  const SizedBox(height: 8),
                  Text(article.articleText),
                  const SizedBox(height: 8),
                  Text(article.articleText),
                ],
              ),
            ),
          ),
        );
      }),
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
