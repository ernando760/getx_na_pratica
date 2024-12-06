import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../errors/storage_exception.dart';
import '../interface/i_storage.dart';

class SharedPreferencesStorage implements IStorage {
  SharedPreferencesStorage(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  StorageResponse getItem(String key) {
    try {
      final result = _sharedPreferences.getString(key);
      if (result == null) {
        return StorageResponse(response: {});
      }

      return StorageResponse(response: {"data": result});
    } catch (error, s) {
      throw StorageException(
          label: "$runtimeType.getItem",
          messageError: error.toString(),
          stackTrace: s);
    }
  }

  @override
  Future<bool> setItem(String key, String data) async {
    try {
      final isAdded = await _sharedPreferences.setString(key, data);

      return isAdded;
    } catch (error, s) {
      throw StorageException(
        label: "$runtimeType.setItem",
        messageError: error.toString(),
        stackTrace: s,
      );
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      final isRemoved = await _sharedPreferences.remove(key);

      return isRemoved;
    } catch (error, s) {
      throw StorageException(
        label: "$runtimeType.remove",
        messageError: error.toString(),
        stackTrace: s,
      );
    }
  }
}
