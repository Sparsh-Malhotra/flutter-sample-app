import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:com.jainyouthnoida.pathshala/pages/books/controllers/book_controller.dart';
import 'package:com.jainyouthnoida.pathshala/pages/books/models/books_response.dart';
import 'package:com.jainyouthnoida.pathshala/utils/app_colors.dart';
import 'package:com.jainyouthnoida.pathshala/utils/resources_manager.dart';

class BookTile extends StatefulWidget {
  const BookTile({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  late BookController _bookController;
  final ResourcesManager _resourcesManager = ResourcesManager();

  @override
  void initState() {
    super.initState();
    _bookController = BookController();
  }

  @override
  void dispose() {
    _bookController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_bookController.isDownloading.value) {
        return ListTile(
          tileColor: AppColors.cardColor,
          leading: const CircularProgressIndicator(
            color: AppColors.primary,
          ),
          title: Text(widget.book.name!),
        );
      } else {
        return FutureBuilder<bool>(
          future: _bookController.isBookDownloaded(widget.book.name!),
          builder: (context, bookSnapshot) {
            return ListTile(
              tileColor: AppColors.cardColor,
              leading: (bookSnapshot.hasData && bookSnapshot.data!)
                  ? const Icon(Icons.file_open)
                  : const Icon(Icons.file_download),
              title: Text(widget.book.name!),
              trailing: (bookSnapshot.hasData && bookSnapshot.data!)
                  ? IconButton(
                      onPressed: () async {
                        await _resourcesManager.deleteBook(widget.book.name!);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete))
                  : null,
              onTap: () async {
                if (await _bookController.isBookDownloaded(widget.book.name!)) {
                  final directory = Platform.isIOS
                      ? await getApplicationDocumentsDirectory()
                      : await getExternalStorageDirectory();
                  final filePath =
                      '${directory?.path}/books/${widget.book.name}.pdf';
                  await OpenFile.open(filePath, type: 'application/pdf');
                } else {
                  await _bookController.downloadBookHandler(
                    widget.book.name!,
                    widget.book.book!,
                    // "https://drive.google.com/uc?export=download&id=1NtG84hMYxVbaQYK2w1bsgLEmwI9zZUwG",
                  );
                }
              },
            );
          },
        );
      }
    });
  }
}
