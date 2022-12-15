import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';
import 'package:home_widget/home_widget_callback_dispatcher.dart';
import 'package:homescreen_widgets/news_data.dart';
import 'package:workmanager/workmanager.dart';

void backgroundCallback(Uri? data) async {
  print("backgroundCallback URI = $data}");

  if (data!.host == 'titleclicked') {
    final greetings = [
      'Hello',
      'Hallo',
      'Bonjour',
      'Hola',
      'Ciao',
      '哈洛',
      '안녕하세요',
      'xin chào'
    ];
    final selectedGreeting = greetings[Random().nextInt(greetings.length)];

    try {
      await HomeWidget.saveWidgetData<String>(
          'headline_title', selectedGreeting);
      await HomeWidget.updateWidget(name: 'NewsWidget', iOSName: 'NewsWidgets');
    } on PlatformException catch (error) {
      print(error);
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
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
    headline = getNewsStories()[1];

    // Set the group ID
    HomeWidget.setAppGroupId('group.leigha.widget');

    // Register Callback to be called by Android
    HomeWidget.registerBackgroundCallback(backgroundCallback);

    // Save the headline data to the widget
    try {
      HomeWidget.saveWidgetData<String>('headline_title', headline.title);
      HomeWidget.saveWidgetData<String>(
          'headline_description', headline.description);
    } on PlatformException catch (error) {
      print('Error updating widget: $error');
    }
  }

  void updateWidget() {
    // Force the widgets to update?
    try {
      HomeWidget.updateWidget(
        name: 'NewsWidget',
        androidName: 'NewsWidget',
      );
    } on PlatformException catch (error) {
      print('Error updating widget: $error');
    }
  }

  void getData() {
    Future.wait([
      HomeWidget.getWidgetData<String>('headline_title', defaultValue: 'News 1')
    ]).then((value) => print(value));
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
            const Spacer(),
            ElevatedButton(
              onPressed: () => updateWidget(),
              child: const Text('Update Widget'),
            ),
            ElevatedButton(
              onPressed: () => getData(),
              child: const Text('Print Widget Data'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateWidget();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
