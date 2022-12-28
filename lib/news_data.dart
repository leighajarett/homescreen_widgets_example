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
      title: "Announcing Flutter Forward",
      description:
          "Flutter Forward is taking place in Nairobi, Kenya in January 2023",
    ),
    NewsArticle(
      title: "Flutter Forward Keynote announcements",
      description:
          "The keynote at Flutter Forward covers the past, present and future",
    ),
    NewsArticle(
      title: "Flutter DAU surpasses 10 billion",
      description:
          "There are more Flutter users than there are human beings. What gives?",
    )
  ];
  return news;
}
