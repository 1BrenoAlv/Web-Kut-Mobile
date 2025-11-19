import 'package:flutter/widgets.dart';
import 'package:web_kut/core/models/users_models.dart';
import 'package:web_kut/core/service/api_users_service.dart';

class AuthViewModel with ChangeNotifier {
  final ApiUsersService _service = ApiUsersService();

  UsersModels? _usuarioLogado;
  bool _carregando = false;
  String? _erroMensagem;

  String? get erroMensagem => _erroMensagem;
  bool get carregando => _carregando;
  UsersModels? get usuarioLogado => _usuarioLogado;

  Future<bool> login(String email, String username) async {
    _carregando = true;
    _erroMensagem = null;
    notifyListeners();

    try {
      final users = await _service.getUsers();
      try {
        final user = users.firstWhere(
          (u) =>
              u.email.toLowerCase() == email.toLowerCase() &&
              u.username.toLowerCase() == username.toLowerCase(),
        );
        _usuarioLogado = user;
        return true;
      } catch (e) {
        _erroMensagem = "Dados incorretos. Tente: Bret / Sincere@april.biz";
        return false;
      }
    } catch (e) {
      _erroMensagem = "Erro de conexão.";
      return false;
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  void logout() {
    _usuarioLogado = null;
    notifyListeners();
  }
}
