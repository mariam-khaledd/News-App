class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? urlToImage;
  String? publishAt;
  String? content;

  ArticleModel({
    this.title,
    this.author,
    this.description,
    this.publishAt,
    this.urlToImage,
    this.content
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      description: json['description'],
      author: json['author'],
      publishAt: json['publishedAt'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}