import 'package:get/get.dart';

import '../../core/services/http_client/interfaces/i_http_client.dart';
import '../../core/storages/interface/i_storage.dart';
import '../controllers/home_controller.dart';
import '../data/repositories/interfaces/i_users_repository.dart';
import '../data/repositories/local_users_repository.dart';
import '../data/repositories/remote_users_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IUsersRepository>(
        () => RemoteUsersRepository(Get.find<IHttpClient>()),
        tag: "REMOTE");
    Get.lazyPut<IUsersRepository>(
        () => LocalUsersRepository(Get.find<IStorage>()),
        tag: "LOCAL");
    Get.put(HomeController(Get.find<IUsersRepository>(tag: "REMOTE")),
        permanent: true);
  }
}
