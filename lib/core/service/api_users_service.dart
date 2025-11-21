import 'dart:convert';
import 'dart:io';
import 'package:web_kut/core/models/users_models.dart';
import 'package:http/http.dart' as http;

class ApiUsersService {
  final String _url = 'https://jsonplaceholder.typicode.com/users';

  // ---METODO GET---
  Future<List<UsersModels>> getUsers() async {
    final Uri uri = Uri.parse(_url);

    try {
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
        },
      );

      if (response.statusCode == 200) {
        final String jsonString = response.body;

        final List<dynamic> jsonList = jsonDecode(jsonString);

        return jsonList
            .map((jsonMap) => UsersModels.fromJson(jsonMap))
            .toList();
      } else {
        throw Exception('Falha ao carregar usuários: ${response.statusCode}');
      }
    } on SocketException {
      // tratar conexao com a internet
      throw Exception('Sem conexão com a internet.');
    } catch (e) {
      throw Exception('Ocorreu um erro: $e');
    }
  }

  // ---METODO POST---
  Future<UsersModels> createUsers(UsersModels user) async {
    final Uri uri = Uri.parse(_url);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return UsersModels.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Falha ao criar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ocorreu um erro ao criar usuário: $e');
    }
  }
}
