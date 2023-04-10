import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/chart_page.dart';
import 'package:homescreen_widgets/news_data.dart';
import 'package:workmanager/workmanager.dart';

import 'color_schemes.g.dart';
import 'news_page.dart';

const String appGroupId = 'group.leighawidget';
const String iOSWidgetName = 'NewsWidgets';
const String AndroidWidgetName = 'NewsWidget';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("this is the task: $task");
    if (task == "demo-task") {
      print("I am in the task");
      HomeWidget.renderFlutterWidget(
          appGroupId, globalKey.currentContext!, "screenshot2", "filename");

      print("Native called demo task"); //simpleTask will be emitted here.
    }
    return Future.value(true);
  });
}

void main() {
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontFamily: "Chewy",
            color: lightColorScheme.primary,
            fontSize: 20,
          ),
        ),
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
  late String newHeadline;

  @override
  void initState() {
    super.initState();
    // Set the group ID
    HomeWidget.setAppGroupId(appGroupId);

    // Mock read in some data and update the headline
    final newHeadline = getNewsStories()[0];
    HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
    HomeWidget.saveWidgetData<String>(
        'headline_description', newHeadline.description);
    HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: AndroidWidgetName,
    );
  }

  int _selectedIndex = 0;
  static final List<Widget> _pages = [
    const ChartPage(),
    const NewsListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.graph_square,
            ),
            label: 'Charts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            label: 'News',
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
