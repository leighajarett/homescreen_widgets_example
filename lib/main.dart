import 'package:flutter/material.dart';
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeScreen Widgets Workshop')),
      body: Center(
        child: ListView.builder(
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
    );
  }

  // TODO: Use deep linking, if we want to add the feature of clicking on an article from the homescreen widget
  void _showArticlePage(BuildContext context, NewsArticle article) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Material(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text(article.title!),
                  Text(article.description!),
                  const Text('TODO: Lorem Ipsum')
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
