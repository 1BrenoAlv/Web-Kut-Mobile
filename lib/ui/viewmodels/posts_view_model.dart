import 'package:flutter/material.dart';
import 'package:web_kut/core/models/posts_models.dart';
import 'package:web_kut/core/service/api_posts_service.dart';

class PostsViewModel with ChangeNotifier {
  final ApiPostsService _service = ApiPostsService();

  bool _carregando = false;
  List<PostsModels> _postList = [];

  String? _errorMensagem;

  bool get carregando => _carregando;
  List<PostsModels> get postList => _postList;
  String? get errorMensagem => _errorMensagem;

  Future<void> getPost() async {
    _carregando = true;
    _errorMensagem = null;
    notifyListeners();

    try {
      _postList = await _service.getPosts();
    } catch (e) {
      _errorMensagem = e.toString();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> createPost(PostsModels post) async {
    _carregando = true;
    _errorMensagem = null;
    notifyListeners();

    try {
      final novoPost = await _service.postPosts(post);
      _postList.add(novoPost);
    } catch (e) {
      _errorMensagem = e.toString();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
