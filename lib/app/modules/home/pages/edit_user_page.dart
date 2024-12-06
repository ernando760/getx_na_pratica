import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/edit_button.dart';
import '../controllers/home_controller.dart';
import '../data/models/user_model.dart';
import '../models/user_form_model.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, this.user});
  final UserModel? user;
  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late final HomeController _homeController;
  late final UserFormModel _userForm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _homeController = Get.find<HomeController>();
    final user = widget.user;
    if (user == null) {
      _userForm = UserFormModel(username: "", lastname: "");
      return;
    }
    _userForm = UserFormModel.fromUserModel(user);
  }

  Future<void> _editUser() async {
    final validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      await _homeController.editUser(_userForm.toUserModel());
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _userForm.id == null ? "Adicionar Usuário" : "Editar Usuário",
          ),
        ),
        body: GetBuilder(
            init: _homeController,
            builder: (controller) {
              return Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: sizeOf.width * .9,
                        child: TextFormField(
                            initialValue: _userForm.username,
                            onChanged: _userForm.setUsername,
                            validator: _userForm.validateUsername,
                            decoration: const InputDecoration(
                                label: Text("Nome"),
                                border: OutlineInputBorder())),
                      ),
                      SizedBox(
                        height: sizeOf.height * .05,
                      ),
                      SizedBox(
                        width: sizeOf.width * .9,
                        child: TextFormField(
                            initialValue: _userForm.lastname,
                            onChanged: _userForm.setLastname,
                            validator: _userForm.validateLastname,
                            decoration: const InputDecoration(
                                label: Text("Sobrenome"),
                                border: OutlineInputBorder())),
                      ),
                      SizedBox(
                        height: sizeOf.height * .1,
                      ),
                      SizedBox(
                        width: sizeOf.width * .9,
                        child: EditButton(
                          label: _userForm.id == null ? "Adicionar" : "Editar",
                          onPressed: _editUser,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
