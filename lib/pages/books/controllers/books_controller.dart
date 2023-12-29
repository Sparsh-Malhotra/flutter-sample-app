import 'package:get/get.dart';
import 'package:pathshala/pages/books/models/books_response.dart';
import 'package:pathshala/services/api/resources_service.dart';
import 'package:pathshala/utils/functions.dart';

class BooksController extends GetxController {
  final ResourcesService _resourcesService = Get.put(ResourcesService());

  // final _books = <Book>[].obs;
  // List<Book> get books => _books;

  Future<List<Book>> getBooksHandler() async {
    try {
      final response = await _resourcesService.getBooks();
      if (response.status == 'success') {
        return response.data;
      } else {
        final errorMessage = response.error.message;
        showErrorMessage(errorMessage);
        return [];
      }
    } catch (e) {
      showErrorMessage(e.toString());
      return [];
    }
  }
}
