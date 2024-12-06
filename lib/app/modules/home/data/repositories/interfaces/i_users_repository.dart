import 'package:result_dart/result_dart.dart';

import '../../errors/user_repository_error.dart';
import '../../models/user_model.dart';

abstract interface class IUsersRepository {
  AsyncResult<List<UserModel>, UserRepositoryError> getAllUsers();
  AsyncResult<List<UserModel>, UserRepositoryError> addUser(UserModel user);
  AsyncResult<List<UserModel>, UserRepositoryError> deleteUser(String id);
  AsyncResult<List<UserModel>, UserRepositoryError> updateUser(UserModel user);
  AsyncResult<List<UserModel>, UserRepositoryError> addManyUsers(
      List<UserModel> users);
  AsyncResult<List<UserModel>, UserRepositoryError> deleteManyUsers(
      List<UserModel> users);
}
