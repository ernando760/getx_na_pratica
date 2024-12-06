import 'dart:async';

abstract interface class IStorage {
  FutureOr<StorageResponse> getItem(String key);
  FutureOr<bool> setItem(String key, String data);
  FutureOr<bool> remove(String key);
}

class StorageResponse {
  final Map<String, dynamic> response;
  StorageResponse({required this.response});
}
