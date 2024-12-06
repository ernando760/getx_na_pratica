import 'dart:developer';

import 'package:result_dart/result_dart.dart';

import '../../../core/services/http_client/errors/http_client_error.dart';
import '../../../core/services/http_client/interfaces/i_http_client.dart';
import '../errors/user_repository_error.dart';
import '../models/user_model.dart';
import 'interfaces/i_users_repository.dart';

class RemoteUsersRepository implements IUsersRepository {
  RemoteUsersRepository(this._httpClient);

  final IHttpClient _httpClient;
  List<UserModel> _users = [];

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> getAllUsers() async {
    try {
      final response = await _httpClient.get("/users");

      final data = response.data["data"];

      _users = List.castFrom<dynamic, Map<String, dynamic>>(data)
          .map((user) => UserModel.fromMap(user))
          .toList();

      return Success(_users);
    } on HttpClientError catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.getAllUsers => ${error.label}",
        messageError: "Erro ao obter o usuário",
        stackTrace: error.stackTrace,
      ));
    } catch (error, st) {
      log(error.toString(), name: "ERROR", stackTrace: st);
      return Failure(UserRepositoryError(
        label: "$runtimeType.getAllUsers",
        messageError: "Ocorreu um erro desconhecido",
        stackTrace: st,
      ));
    }
  }

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> addUser(
      UserModel user) async {
    try {
      await _httpClient.post("/users", data: {
        "username": user.username,
        "lastname": user.lastname,
      });

      _users = [..._users, user];

      return Success(_users);
    } on HttpClientError catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addUser => ${error.label}",
        messageError: "Erro ao adicionar o usuário",
        stackTrace: error.stackTrace,
      ));
    } catch (error, st) {
      log(error.toString(), name: "ERROR", stackTrace: st);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addUser",
        messageError: "Ocorreu um erro desconhecido",
        stackTrace: st,
      ));
    }
  }

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> deleteUser(
      String id) async {
    try {
      await _httpClient.delete("/users/$id");

      _users = _users.where((user) => user.id != id).toList();

      return Success(_users);
    } on HttpClientError catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.deleteUser => ${error.label}",
        messageError: "Erro ao deletar o usuário",
        stackTrace: error.stackTrace,
      ));
    } catch (error, st) {
      log(error.toString(), name: "ERROR", stackTrace: st);
      return Failure(UserRepositoryError(
        label: "$runtimeType.deleteUser",
        messageError: "Ocorreu um erro desconhecido",
        stackTrace: st,
      ));
    }
  }

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> updateUser(
      UserModel updateUser) async {
    try {
      await _httpClient.put("/users/${updateUser.id}", data: {
        "username": updateUser.username,
        "lastname": updateUser.lastname,
      });

      _users = _users
          .map((user) => user.id == updateUser.id ? updateUser : user)
          .toList();

      return Success(_users);
    } on HttpClientError catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.deleteUser => ${error.label}",
        messageError: "Erro ao atualizar o usuário",
        stackTrace: error.stackTrace,
      ));
    } catch (error, st) {
      log(error.toString(), name: "ERROR", stackTrace: st);
      return Failure(UserRepositoryError(
        label: "$runtimeType.deleteUser",
        messageError: "Ocorreu um erro desconhecido",
        stackTrace: st,
      ));
    }
  }

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> addManyUsers(
      List<UserModel> users) async {
    try {
      await Future.wait(users.map((user) => _httpClient.post("/users", data: {
            "username": user.username,
            "lastname": user.lastname,
          })));

      _users = [..._users, ...users];

      return Success(_users);
    } on HttpClientError catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addManyUsers => ${error.label}",
        messageError: "Erro ao adicionar muitos os usuários",
        stackTrace: error.stackTrace,
      ));
    } catch (error, st) {
      log(error.toString(), name: "ERROR", stackTrace: st);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addManyUsers",
        messageError: "Ocorreu um erro desconhecido",
        stackTrace: st,
      ));
    }
  }

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> deleteManyUsers(
      List<UserModel> users) async {
    try {
      await Future.wait(
          users.map((user) => _httpClient.delete("/users/${user.id}")));

      _users = _users.where((user) {
        return users.any((deletedUser) => deletedUser.id != user.id);
      }).toList();

      return Success(_users);
    } on HttpClientError catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addManyUsers => ${error.label}",
        messageError: "Erro ao  muitos os usuários",
        stackTrace: error.stackTrace,
      ));
    } catch (error, st) {
      log(error.toString(), name: "ERROR", stackTrace: st);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addManyUsers",
        messageError: "Ocorreu um erro desconhecido",
        stackTrace: st,
      ));
    }
  }
}
