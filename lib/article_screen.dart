import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/news_data.dart';
import 'main.dart';

// This should be removed when HomeWidget package is updated
extension HomeWidgetRenderExtension on HomeWidget {
  renderFlutterWidget(
      String appGroup, BuildContext context, String a, String b) {
    throw Error;
  }
}

class ArticleScreen extends StatefulWidget {
  final NewsArticle article;

  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final _globalKey = GlobalKey();
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_globalKey.currentContext != null) {
            print("Rendering widget...");
            var path = await HomeWidget.renderFlutterWidget(
              LineChart(),
              fileName: 'screenshot',
              key: 'filename',
              logicalSize: _globalKey.currentContext!.size,
              pixelRatio:
                  MediaQuery.of(_globalKey.currentContext!).devicePixelRatio,
            );
            setState(() {
              imagePath = path;
            });
          }
          updateHeadline(widget.article);
        },
        label: const Text('Update Homescreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (widget.article.image != null)
              //   Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Center(
              //       child: Image.asset('assets/images/${widget.article.image}'),
              //     ),
              //   ),
              const SizedBox(height: 10.0),
              Text(
                widget.article.description!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20.0),
              Text(widget.article.articleText),
              const SizedBox(height: 20.0),
              Center(
                // key should be removed in the first version
                key: _globalKey,
                child: LineChart(),
              ),
              const SizedBox(height: 20.0),
              Text(widget.article.articleText),
            ],
          ),
        ),
      ),
    );
  }
}

class LineChart extends StatelessWidget {
  const LineChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(),
      child: const SizedBox(
        height: 200,
        width: 200,
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
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final markingLinePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final mockDataPoints = [
      const Offset(15, 155),
      const Offset(20, 133),
      const Offset(34, 125),
      const Offset(40, 105),
      const Offset(70, 85),
      const Offset(80, 95),
      const Offset(90, 60),
      const Offset(120, 54),
      const Offset(160, 60),
      const Offset(200, -10),
    ];

    final axis = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);

    final markingLine = Path()
      ..moveTo(-10, 50)
      ..lineTo(size.width + 10, 50);

    final data = Path()..moveTo(1, 180);

    for (var dataPoint in mockDataPoints) {
      data.lineTo(dataPoint.dx, dataPoint.dy);
    }

    canvas.drawPath(axis, axisPaint);
    canvas.drawPath(data, dataPaint);
    canvas.drawPath(markingLine, markingLinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
