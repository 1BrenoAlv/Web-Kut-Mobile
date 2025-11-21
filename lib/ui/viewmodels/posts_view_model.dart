import 'package:flutter/material.dart';
import 'package:web_kut/core/models/posts_models.dart';
import 'package:web_kut/core/models/users_models.dart';
import 'package:web_kut/core/service/api_posts_service.dart';
import 'package:web_kut/core/service/api_users_service.dart';

class PostsViewModel with ChangeNotifier {
  final ApiPostsService _service = ApiPostsService();
  final ApiUsersService _userService = ApiUsersService();

  bool _carregando = false;
  List<PostsModels> _postList = [];
  List<UsersModels> _userList = [];

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

      _userList = await _userService.getUsers();
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

  String getNomeAutor(int userId) {
    if (_userList.isEmpty) {
      return "Carregando...";
    }

    try {
      final user = _userList.firstWhere((u) => u.id == userId);
      return user.name;
    } catch (e) {
      return "Desconhecido";
    }
  }

  Future<void> getMyPosts(int userId) async {
    _carregando = true;
    notifyListeners();
    try {
      _postList = await _service.getPostByUser(userId);
    } catch (e) {
      _errorMensagem = e.toString();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
