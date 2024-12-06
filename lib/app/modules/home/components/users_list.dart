import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../data/models/user_model.dart';
import '../pages/edit_user_page.dart';
import 'user_info_item.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key, required this.users, this.scrollController});
  final ScrollController? scrollController;
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return ReorderableListView.builder(
      scrollController: scrollController,
      buildDefaultDragHandles: false,
      itemCount: users.length,
      onReorder: (oldIndex, newIndex) =>
          controller.onReoder(oldIndex: oldIndex, newIndex: newIndex),
      itemBuilder: (_, index) {
        final user = users[index];

        return ReorderableDragStartListener(
          index: index,
          key: ValueKey("${user.id}"),
          child: Dismissible(
            key: Key("${user.id}"),
            onDismissed: (_) async => await controller.deleteUser(user.id),
            background: Container(
              color: Colors.redAccent,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: UserInfoItem(
                user: user,
                onSelectedUser: (user) =>
                    Get.to(() => EditUserPage(user: user))),
          ),
        );
      },
    );
  }
}
