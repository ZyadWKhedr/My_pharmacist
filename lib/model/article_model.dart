class Article {
  final int id;
  final String title;
  final String url;
  final String description;

  Article({
    required this.id,
    required this.title,
    required this.url,
    required this.description,
  });

  // Factory constructor to create an Article object from JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      description: json['description'],
    );
  }
}