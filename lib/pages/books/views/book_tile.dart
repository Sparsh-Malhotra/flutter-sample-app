import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pathshala/pages/books/controllers/book_controller.dart';
import 'package:pathshala/pages/books/models/books_response.dart';
import 'package:pathshala/utils/app_colors.dart';

class BookTile extends StatefulWidget {
  const BookTile({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  late BookController _bookController;

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
        return ListTile(
          tileColor: AppColors.cardColor,
          leading: FutureBuilder<bool>(
            future: _bookController.isBookDownloaded(widget.book.name!),
            builder: (context, bookSnapshot) {
              if (bookSnapshot.hasData && bookSnapshot.data!) {
                return const Icon(Icons.file_open);
              } else {
                return const Icon(Icons.file_download);
              }
            },
          ),
          title: Text(widget.book.name!),
          // trailing: FutureBuilder<bool>(
          //   future: _bookController.isBookDownloaded(widget.book.name!),
          //   builder: (context, bookSnapshot) {
          //     if (bookSnapshot.hasData && bookSnapshot.data!) {
          //       return const Icon(
          //         Icons.delete,
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
          onTap: () async {
            if (await _bookController.isBookDownloaded(widget.book.name!)) {
              final directory = await getApplicationDocumentsDirectory();
              final filePath = '${directory.path}/books/${widget.book.name}';

              await OpenFile.open(filePath, type: 'application/pdf');
            } else {
              await _bookController.downloadBookHandler(
                widget.book.name!,
                widget.book.book!,
              );
            }
          },
        );
      }
    });
  }
}
