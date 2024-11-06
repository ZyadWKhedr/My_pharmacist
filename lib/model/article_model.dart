class Article {
  final int id;
  final String title;
  final String photo;
  final String link;

  Article(
      {required this.id,
      required this.title,
      required this.photo,
      required this.link});

  // Factory constructor to parse JSON data
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      photo: json['photo'],
      link: json['link'],
    );
  }

  // Method to convert the article to JSON format (useful for API requests)
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'photo': photo,
        'link': link,
      };
}
