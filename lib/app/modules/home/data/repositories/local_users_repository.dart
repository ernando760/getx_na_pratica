import 'dart:convert';
import 'dart:developer';

import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../../../core/storages/errors/storage_exception.dart';
import '../../../core/storages/interface/i_storage.dart';
import '../errors/user_repository_error.dart';
import '../models/user_model.dart';
import 'interfaces/i_users_repository.dart';

const USERS_KEY_STORAGE = "@GETX_NA_PRATICA:users";

class LocalUsersRepository implements IUsersRepository {
  LocalUsersRepository(this._storage);

  final IStorage _storage;

  @override
  AsyncResult<List<UserModel>, UserRepositoryError> getAllUsers() async {
    try {
      final storageResponse = await _storage.getItem(USERS_KEY_STORAGE);

      log("${storageResponse.response["data"]}", name: "DATA");
      final data = storageResponse.response["data"];

      if (data == null) {
        return const Success([]);
      }

      final dataCast =
          List.castFrom<dynamic, Map<String, dynamic>>(json.decode(data));

      final users = dataCast.map((user) => UserModel.fromMap(user)).toList();

      return Success(users);
    } on StorageException catch (error) {
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
      final geItemResponse = await _storage.getItem(USERS_KEY_STORAGE);

      final data = geItemResponse.response["data"] ?? "[]";

      final valueDecoded =
          List.castFrom<dynamic, Map<String, dynamic>>(json.decode(data));

      final uuid = const Uuid().v6();

      user = user.copyWith(id: uuid);

      final usersMap = [...valueDecoded, user.toMap()];

      await _storage.setItem(USERS_KEY_STORAGE, json.encode(usersMap));

      final users = usersMap.map((user) => UserModel.fromMap(user)).toList();

      return Success(users);
    } on StorageException catch (error) {
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
      final storageResponse = await _storage.getItem(USERS_KEY_STORAGE);

      var data = List.castFrom<dynamic, Map<String, dynamic>>(
          json.decode(storageResponse.response["data"] ?? "[]"));

      data = data.where((userMap) => userMap["id"] != id).toList();

      final dataString = json.encode(data);

      await _storage.setItem(USERS_KEY_STORAGE, dataString);

      final users = data.map((user) => UserModel.fromMap(user)).toList();

      return Success(users);
    } on StorageException catch (error) {
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
      final geItemResponse = await _storage.getItem(USERS_KEY_STORAGE);

      final data = json.decode(geItemResponse.response["data"] ?? "[]");

      var usersMap = List.castFrom<dynamic, Map<String, dynamic>>(data);

      final updatedUser = usersMap.map((map) {
        final user = UserModel.fromMap(map);
        return user.id == updateUser.id ? updateUser : user;
      }).toList();

      usersMap = updatedUser.map((user) => user.toMap()).toList();

      final isUpdate =
          await _storage.setItem(USERS_KEY_STORAGE, json.encode(usersMap));

      if (!isUpdate) {
        return const Success([]);
      }

      return Success(updatedUser);
    } on StorageException catch (error) {
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
      final usersMaps = users.map((user) => user.toMap());

      final storageResponse = await _storage.getItem(USERS_KEY_STORAGE);

      final data = List.castFrom<dynamic, Map<String, dynamic>>(
          json.decode(storageResponse.response["data"] ?? "[]"));

      final value = [...data, ...usersMaps];

      final usersString = json.encode(value);

      final isAdd = await _storage.setItem(USERS_KEY_STORAGE, usersString);

      if (isAdd) {
        return Success(value.map((map) => UserModel.fromMap(map)).toList());
      }

      return const Success([]);
    } on StorageException catch (error) {
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
      final storageResponse = await _storage.getItem(USERS_KEY_STORAGE);

      final data = List.castFrom<dynamic, Map<String, dynamic>>(
          json.decode(storageResponse.response["data"] ?? "[]"));

      final value = data
          .where((userMap) => users.any((user) => userMap["id"] != user.id))
          .toList();

      final usersString = json.encode(value);

      final isAdd = await _storage.setItem(USERS_KEY_STORAGE, usersString);

      if (isAdd) {
        return Success(value.map((map) => UserModel.fromMap(map)).toList());
      }

      return const Success([]);
    } on StorageException catch (error) {
      log(error.messageError, name: "ERROR", stackTrace: error.stackTrace);
      return Failure(UserRepositoryError(
        label: "$runtimeType.addManyUsers => ${error.label}",
        messageError: "Erro ao deletar muitos os usuários",
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
