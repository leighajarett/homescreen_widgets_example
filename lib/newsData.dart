// Mock up some news article data

class newsArticle {
  String? title;
  String? description;

  newsArticle({
    this.title,
    this.description,
  });
}

List<newsArticle> getNewsStories() {
  List<newsArticle> news = [];
  news = [
    newsArticle(
      title: "News 1",
      description: "Description 1",
    ),
    newsArticle(
      title: "News 2",
      description: "Description 2",
    ),
    newsArticle(
      title: "News 3",
      description: "Description 3",
    )
  ];
  return news;
}
