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

class MyHomePage extends StatelessWidget {
  // Read in some data
  newsArticle headline = getNewsStories()[0];

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MY LOGO')),
        body: Center(
            child: Column(
          children: [
            Text(headline.title!),
            Text(headline.description!),
          ],
        )));
  }
}
