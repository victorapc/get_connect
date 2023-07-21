import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';

import 'package:get_connect_example/repositories/user_repository.dart';

class HomeController extends GetxController with StateMixin<List<UserModel>> {
  final UserRepository _repository;

  HomeController({
    required UserRepository repository,
  }) : _repository = repository;

  @override
  onReady() {
    _findAll();
    super.onReady();
  }

  Future<void> _findAll() async {
    try {
      change([], status: RxStatus.loading());

      final users = await _repository.findAll();
      var statusReturn = RxStatus.success();

      if (users.isEmpty) {
        statusReturn = RxStatus.empty();
      }

      change(users, status: statusReturn);
    } catch (e, s) {
      log('Erro ao buscar usuários.', error: e, stackTrace: s);
      change(state, status: RxStatus.error());
    }
  }

  Future<void> register() async {
    try {
      final user = UserModel(
        name: 'Victor Alexandre',
        email: 'victor_apc@yahoo.com.br',
        password: '123456',
      );
      await _repository.saveUser(user);
      _findAll();
    } catch (e, s) {
      log('Erro ao registrar o usuário.', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao registrar o usuário.');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      user.name = 'Victor Alexandre P.';
      user.email = 'victorapc@gmail.com.br';
      await _repository.updateUser(user);
      _findAll();
    } catch (e, s) {
      log('Erro ao registrar o usuário.', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao atualizar o usuário.');
    }
  }

  Future<void> deleteUser(UserModel user) async {
    try {
      await _repository.deleteUser(user);
      Get.snackbar('Sucesso', 'Usuário deletado com sucesso.');
      _findAll();
    } catch (e, s) {
      log('Erro ao deletar o usuário.', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao deletar o usuário.');
    }
  }
}
