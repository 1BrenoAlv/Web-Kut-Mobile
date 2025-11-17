import 'dart:convert';
import 'dart:io';

import 'package:web_kut/core/models/posts_models.dart';
import 'package:http/http.dart' as http;

class ApiPostsService {
  final String _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostsModels>> getPosts() async {
    final Uri uri = Uri.parse(_url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final String jsonString = response.body;
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList
            .map((jsonMap) => PostsModels.fromJson(jsonMap))
            .toList();
      } else {
        throw Exception('Falha ao carregar os posts');
      }
    } on SocketException {
      throw Exception('Sem conexão com a internet');
    } catch (e) {
      throw Exception('Ocorreu um erro: $e');
    }
  }

  Future<PostsModels> postPosts(PostsModels post) async {
    final Uri uri = Uri.parse(_url);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode == 201) {
        return PostsModels.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Erro ao criar um post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ocorreu um erro ao criar post: $e');
    }
  }
}
