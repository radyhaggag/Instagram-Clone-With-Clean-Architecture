import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class CashManager {
  static Future<String> get _localPath async {
    final Directory directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
    }
    final path = "${directory.path}/instagram";
    if (!Directory(path).existsSync()) {
      Directory(path).createSync();
    }
    return path;
  }

  static Future<String> saveFile(String url, String saveName) async {
    final path = await _localPath;
    final fullPath = "$path/$saveName.png";
    if (!File(fullPath).existsSync()) {
      try {
        await Dio().download(url, fullPath);
        return fullPath;
      } catch (e) {
        rethrow;
      }
    } else {
      return fullPath;
    }
  }
}
