import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _tokenFile async {
    final path = await _localPath;
    return File('$path/token.txt');
  }

  Future<String> getToken() async {
    try {
      final file = await _tokenFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> setToken(String token) async {
    final file = await _tokenFile;

    // Write the file
    return file.writeAsString(token);
  }

  Future<File> cleanToken() async {
    final file = await _tokenFile;

    // Write the file
    return file.writeAsString('');
  }

  Future<File> get _languageFile async {
    final path = await _localPath;
    return File('$path/language.txt');
  }

  Future<String> getLanguage() async {
    try {
      final file = await _languageFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> setLanguage(String language) async {
    final file = await _languageFile;

    // Write the file
    return file.writeAsString(language);
  }
}
