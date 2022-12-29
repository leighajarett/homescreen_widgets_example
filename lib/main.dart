import 'package:flutter/material.dart';
import 'package:homescreen_widgets/news_data.dart';

import 'color_schemes.g.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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

  // TODO: Use deep linking, if we want to add the feature of clicking on an article from the homescreen widget
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
                        child: Image.asset('assets/images/${article.image}'),
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
