import 'package:com.jainyouthnoida.pathshala/pages/books/models/books_response.dart';
import 'package:com.jainyouthnoida.pathshala/services/api/resources_service.dart';
import 'package:com.jainyouthnoida.pathshala/utils/functions.dart';
import 'package:get/get.dart';

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
