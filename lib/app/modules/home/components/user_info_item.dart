import 'package:flutter/material.dart';
import 'package:getx_na_pratica/app/modules/home/data/models/user_model.dart';

class UserInfoItem extends StatelessWidget {
  const UserInfoItem(
      {super.key, required this.user, this.onSelectedUser, this.onDismissed});
  final UserModel user;
  final void Function(UserModel user)? onSelectedUser;
  final void Function(DismissDirection dismissDirection)? onDismissed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.username),
      subtitle: Text(user.lastname),
      onTap: onSelectedUser != null ? () => onSelectedUser?.call(user) : null,
    );
  }
}
