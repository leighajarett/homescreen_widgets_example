import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/chart_page.dart';
import 'package:homescreen_widgets/news_data.dart';

import 'color_schemes.g.dart';
import 'news_page.dart';

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
      // Save the headline data to the widget
      HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
      HomeWidget.saveWidgetData<String>(
          'headline_description', newHeadline.description);
      HomeWidget.updateWidget(iOSName: 'NewsWidgets');
    });
  }

  int _selectedIndex = 0;
  static final List<Widget> _pages = [const NewsListPage(), const ChartPage()];

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
            icon: Icon(CupertinoIcons.news),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.graph_square,
            ),
            label: 'Charts',
          )
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
