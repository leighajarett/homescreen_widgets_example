import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/homescreen_utils.dart';
import 'package:homescreen_widgets/news_data.dart';

import 'color_schemes.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  void initState() {
    super.initState();
    // Set the group ID
    HomeWidget.setAppGroupId('group.leighawidget');

    // Mock read in some data and update the headline
    final newHeadline = getNewsStories()[0];
    HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
    HomeWidget.saveWidgetData<String>(
        'headline_description', newHeadline.description);
    HomeWidget.updateWidget(
      iOSName: 'NewsWidgets',
      androidName: 'NewsWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/FlutterForward_Logo_Dark_Gradient.png'),
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
