import 'dart:convert';

class Article {
  final String title;
  final String content;

  Article({
    required this.title,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}

Article articleFromJson(String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  return Article.fromJson(jsonMap);
}

String articleToJson(Article data) {
  final Map<String, dynamic> jsonMap = data.toJson();
  return json.encode(jsonMap);
}

List<Article> articlesFromJson(String str) {
  final List<dynamic> jsonArray = json.decode(str);
  return List<Article>.from(jsonArray.map((item) => Article.fromJson(item)));
}

String articlesToJson(List<Article> data) {
  final List<Map<String, dynamic>> jsonList = data.map((item) => item.toJson()).toList();
  return json.encode(jsonList);
}