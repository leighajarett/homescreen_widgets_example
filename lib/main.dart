import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/news_data.dart';

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

  @override
  void initState() {
    super.initState();
    // Mock read in some data
    headline = getNewsStories()[0];
    // Set the group ID
    HomeWidget.setAppGroupId('group.leigha.widget');
    // Save the headline data to the widget
    HomeWidget.saveWidgetData<String>('headline_title', headline.title);

    HomeWidget.saveWidgetData<String>(
        'headline_description', headline.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY LOGO')),
      body: Center(
        child: Column(
          children: [
            Text(headline.title!),
            Text(headline.description!),
          ],
        ),
      ),
    );
  }
}
