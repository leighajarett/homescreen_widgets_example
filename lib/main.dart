import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homescreen_widgets/newsData.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';

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

  void initState() {
    super.initState();
    // Set the group ID
    HomeWidget.setAppGroupId('group.leighawidget');
    // Mock read in some data
    // headline = getNewsStories()[0];
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
          ],
        )));
  }
}
