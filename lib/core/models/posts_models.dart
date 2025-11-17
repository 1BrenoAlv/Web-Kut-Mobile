import 'dart:convert';

PostsModels postsModelsFromJson(String str) =>
    PostsModels.fromJson(json.decode(str));

String postsModelsToJson(PostsModels data) => json.encode(data.toJson());

class PostsModels {
  final int userId;
  final int id;
  String title;
  String body;

  PostsModels({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostsModels.fromJson(Map<String, dynamic> json) => PostsModels(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
