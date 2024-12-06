import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/users_list.dart';
import '../controllers/home_controller.dart';
import 'edit_user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _homeController = Get.find<HomeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _homeController.getAllUsers();
    });
  }

  @override
  void dispose() {
    _homeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (_homeController.isLoading) {
                return const CircularProgressIndicator();
              }
              return _homeController.users.isEmpty
                  ? const Text("Nenhum usuário adicionado!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
                  : Expanded(
                      child: UsersList(
                      users: _homeController.users,
                    ));
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () => Get.to(() => const EditUserPage()),
          label: const Text("Usuário")),
    );
  }
}
