import 'dart:collection';

import 'package:get/get.dart';

import '../data/models/user_model.dart';
import '../data/repositories/interfaces/i_users_repository.dart';

class HomeController extends GetxController {
  HomeController(this._usersRepository);

  final IUsersRepository _usersRepository;

  final RxList<UserModel> _users = <UserModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _messageError = "".obs;

  UnmodifiableListView<UserModel> get users => UnmodifiableListView(_users);
  bool get isLoading => _isLoading.value;
  String get messageError => _messageError.value;

  Future<void> getAllUsers() async {
    _setLoading(true);

    final result = await _usersRepository.getAllUsers();

    result.fold((users) => _users.value = users,
        (error) => _messageError.value = error.messageError);

    _setLoading(false);
  }

  Future<void> _addUser(UserModel user) async {
    _setLoading(true);
    final result = await _usersRepository.addUser(user);

    result.fold(
      (users) => _users.value = users,
      (error) => _messageError.value = error.messageError,
    );
    _setLoading(false);
  }

  Future<void> deleteUser(String? id) async {
    if (id == null) return;

    final result = await _usersRepository.deleteUser(id);

    result.fold(
      (users) => _users.value = users,
      (error) => _messageError.value = error.messageError,
    );
  }

  Future<void> _updateUser(UserModel user) async {
    _setLoading(true);
    if (user.id == null) return;

    final result = await _usersRepository.updateUser(user);

    result.fold(
      (users) => _users.value = users,
      (error) => _messageError.value = error.messageError,
    );
    _setLoading(false);
  }

  void _setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  Future<void> editUser(UserModel user) async {
    final id = user.id;
    if (id == null) {
      await _addUser(user);
    } else {
      await _updateUser(user);
    }
  }

  Future<void> onReoder({required int oldIndex, required newIndex}) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = _users.removeAt(oldIndex);
    _users.insert(newIndex, item);

    // await _usersRepository.deleteManyUsers(users);

    // final result = await _usersRepository.addManyUsers(_users);

    // result.fold(
    //   (users) => _users.value = users,
    //   (error) => _messageError.value = error.messageError,
    // );
  }
}
