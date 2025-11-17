import 'package:flutter/material.dart';
import 'package:web_kut/core/models/users_models.dart';
import 'package:web_kut/core/service/api_users_service.dart';

class UsersViewModel with ChangeNotifier {
  final ApiUsersService _service = ApiUsersService();

  bool _carregando = false;
  List<UsersModels> _usersList = [];

  String? _errorMensagem;

  bool get carregando => _carregando;
  List<UsersModels> get usersList => _usersList;
  String? get errorMensagem => _errorMensagem;

  Future<void> getUsers() async {
    _carregando = true;
    _errorMensagem = null;
    notifyListeners();

    try {
      _usersList = await _service.getUsers();
    } catch (e) {
      _errorMensagem = e.toString();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> createUsers(UsersModels user) async {
    _carregando = true;
    _errorMensagem = null;
    notifyListeners();

    try {
      final novoUser = await _service.createUsers(user);
      _usersList.add(novoUser);
    } catch (e) {
      _errorMensagem = e.toString();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }
}
