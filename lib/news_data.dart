// Mock up some news article data

class NewsArticle {
  String? title;
  String? description;

  NewsArticle({
    this.title,
    this.description,
  });
}

List<NewsArticle> getNewsStories() {
  List<NewsArticle> news = [];
  news = [
    NewsArticle(
      title: "News 1",
      description: "Description 1",
    ),
    NewsArticle(
      title: "News 2",
      description: "Description 2",
    ),
    NewsArticle(
      title: "News 3",
      description: "Description 3",
    )
  ];
  return news;
}
