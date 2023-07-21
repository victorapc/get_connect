import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';

class UserRepository {
  final restClient = GetConnect(
    timeout: const Duration(seconds: 10),
  );

  UserRepository() {
    restClient.httpClient.baseUrl = 'http://192.168.0.108:8080';
    // Responsável em fazer tentativas de conexão.
    restClient.httpClient.maxAuthRetries = 3;

    restClient.httpClient.addAuthenticator<Object?>((request) async {
      log('addAuthenticator Chamado!!!');
      const email = 'victorapc@gmail.com.br';
      const password = '123456';

      final result = await restClient.post('/auth', {
        'email': email,
        'password': password,
      });

      if (!result.hasError) {
        final acessToken = result.body['access_token'];
        final type = result.body['type'];
        if (acessToken != null) {
          request.headers['authorization'] = '$type $acessToken';
        }
      } else {
        log('Erro ao fazer login.');
        Get.snackbar('Erro', 'Erro ao fazer login.');
      }

      return request;
    });

    restClient.httpClient.addRequestModifier<Object?>((request) {
      log(request.url.toString());
      request.headers['start-time'] = DateTime.now().toIso8601String();

      return request;
    });
    restClient.httpClient.addResponseModifier((request, response) {
      response.headers?['end-time'] = DateTime.now().toIso8601String();

      return response;
    });
  }

  Future<List<UserModel>> findAll() async {
    final result = await restClient.get('/users');

    if (result.hasError) {
      throw Exception(
          'Erro ao buscar usuários: (${result.status} - ${result.statusText})');
    }

    log(result.request?.headers['start-time'] ?? '');
    log(result.headers?['end-time'] ?? '');

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
