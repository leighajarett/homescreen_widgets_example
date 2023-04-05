// Mock up some news article data

class NewsArticle {
  String? title;
  String? description;

  NewsArticle({
    this.title,
    this.description,
    this.image,
  });

  final String articleText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";

  final String? image;
}

List<NewsArticle> getNewsStories() {
  List<NewsArticle> news = [];
  news = [
    NewsArticle(
      title: "Flutter DAU surpasses 10 billion",
      description:
          "There are more Flutter users than there are human beings. What gives?",
    ),
    NewsArticle(
        title: "Remembering Flutter Forward",
        description:
            "Flutter Forward took place in Nairobi, Kenya in January 2023",
        image: "Flutter_Forward_Teaser_Still_1x1_v01_small.jpg"),
    NewsArticle(
      title: "Flutter Community Member saves world",
      description: "They're just that nice",
    ),
    NewsArticle(
      title: "Flutter DAU surpasses 10 billion",
      description:
          "There are more Flutter users than there are human beings. What gives?",
    )
  ];
  return news;
}
