import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';

class UserRepository {
  final restClient = GetConnect(
    timeout: const Duration(seconds: 10),
  );

  UserRepository() {
    restClient.httpClient.baseUrl = 'http://192.168.0.108:8080';
  }

  Future<List<UserModel>> findAll() async {
    final result = await restClient.get('/users');

    if (result.hasError) {
      throw Exception(
          'Erro ao buscar usuários: (${result.status} - ${result.statusText})');
    }

    return result.body
        .map<UserModel>((user) => UserModel.fromMap(user))
        .toList();
  }

  Future<void> saveUser(UserModel user) async {
    final result = await restClient.post('/users', user.toMap());

    if (result.hasError) {
      throw Exception(
          'Erro ao gravar usuário: (${result.status} - ${result.statusText})');
    }
  }

  Future<void> deleteUser(UserModel user) async {
    final result = await restClient.delete('/users/${user.id}');

    if (result.hasError) {
      throw Exception(
          'Erro ao deletar usuário: (${result.status} - ${result.statusText})');
    }
  }

  Future<void> updateUser(UserModel user) async {
    final result = await restClient.put('/users/${user.id}', user.toMap());

    if (result.hasError) {
      throw Exception(
          'Erro ao atualizar usuário: (${result.status} - ${result.statusText})');
    }
  }
}
