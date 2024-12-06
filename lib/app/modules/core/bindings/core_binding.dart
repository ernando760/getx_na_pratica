import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/http_client/dio/dio_http_client.dart';
import '../services/http_client/interfaces/i_http_client.dart';
import '../storages/interface/i_storage.dart';
import '../storages/shared_preferences/shared_preferences_storage.dart';

Future<IStorage> _makeSharedPreferencesStorage() async {
  final sp = await SharedPreferences.getInstance();
  return SharedPreferencesStorage(sp);
}

Future<void> initStorage() async {
  Get.putAsync<IStorage>(_makeSharedPreferencesStorage);
}

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() {
      const API_URL = String.fromEnvironment("API_URL");
      return Dio(BaseOptions(baseUrl: API_URL));
    });
    Get.lazyPut<IHttpClient>(() => DioHttpClient(Get.find<Dio>()));
  }
}
