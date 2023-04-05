// import 'package:flutter/cupertino.dart';
//
// class ChartPage extends StatefulWidget {
//   const ChartPage({Key? key}) : super(key: key);
//   @override
//   State<ChartPage> createState() => _ChartPageState();
// }
//
// class _ChartPageState extends State<ChartPage> {
//   final _globalKey = GlobalKey();
//   String? imagePath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * .2),
//             Center(
//               child: RepaintBoundary(
//                 key: _globalKey,
//                 child: CustomPaint(
//                   // painter: LineChartPainter(),
//                   child: const SizedBox(
//                     height: 200,
//                     width: 200,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 60),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50.0),
//               child: CupertinoButton.filled(
//                 child: const Text("save screenshot"),
//                 onPressed: () async {
//                   // if (_globalKey.currentContext != null) {
//                   //   var path = await HomeWidget.renderFlutterWidget(
//                   //       'group.leighawidget',
//                   //       _globalKey.currentContext!,
//                   //       "screenshot",
//                   //       "filename");
//                   //   // _saveScreenShot();
//                   //   setState(() {
//                   //     imagePath = path;
//                   //   });
//                   // }
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50.0),
//               child: CupertinoButton.filled(
//                 child: const Text("update homescreen widget image"),
//                 onPressed: () {
//                   _updateImageForWidget();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
