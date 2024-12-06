import '../data/models/user_model.dart';

class UserFormModel {
  UserFormModel(
      {String? id, required String username, required String lastname})
      : _id = id,
        _username = username,
        _lastname = lastname;
  String? _id;
  String _username = "";
  String _lastname = "";

  String? get id => _id;
  String get username => _username;
  String get lastname => _lastname;

  void setUsername(String username) => _username = username;
  void setLastname(String lastname) => _lastname = lastname;

  factory UserFormModel.fromUserModel(UserModel user) => UserFormModel(
        id: user.id,
        username: user.username,
        lastname: user.lastname,
      );

  UserModel toUserModel() =>
      UserModel(id: _id, username: username, lastname: lastname);

  @override
  String toString() =>
      "$runtimeType(id: $_id, username: $_username, lastname: $_lastname)";
}

extension UserFormModelValidator on UserFormModel {
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "O nome do usuário não pode ser vazio";
    }
    return null;
  }

  String? validateLastname(String? lastname) {
    if (lastname == null || lastname.isEmpty) {
      return "O sobrenome do usuário não pode ser vazio";
    }
    return null;
  }
}
