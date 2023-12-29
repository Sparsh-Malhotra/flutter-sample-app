import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pathshala/utils/functions.dart';

class ResourcesManager {
  final Dio _dio = Dio();

  Future<String> get booksLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/books';
  }

  Future<File> _localBooksFile(String filename) async {
    final path = await booksLocalPath;
    return File('$path/$filename');
  }

  Future<void> init() async {
    final path = await booksLocalPath;
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  Future<void> saveBook(String filename, String content) async {
    final file = await _localBooksFile(filename);
    await file.writeAsString(content);
  }

  Future<String> loadBook(String filename) async {
    try {
      final file = await _localBooksFile(filename);
      return await file.readAsString();
    } catch (e) {
      showErrorMessage(e.toString());
      return '';
    }
  }

  Future<void> deleteBook(String filename) async {
    final file = await _localBooksFile(filename);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> downloadBook(String filename, String url) async {
    try {
      final response = await _dio.get(url);
      final content = response.data.toString();
      await saveBook(filename, content);
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }
}
