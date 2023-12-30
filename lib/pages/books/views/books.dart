import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/books/controllers/books_controller.dart';
import 'package:pathshala/pages/books/views/book_tile.dart';
import 'package:pathshala/utils/curves/small_curve.dart';
import 'package:pathshala/utils/functions.dart';
import 'package:pathshala/utils/resources_manager.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final BooksController _booksController = Get.put(BooksController());
  final resourcesManager = ResourcesManager();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    resourcesManager.init();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topBarHeight = 135;

    return Scaffold(
      body: FutureBuilder(
        future: _booksController.getBooksHandler(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No books found'),
            );
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 132, bottom: 20),
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final book = snapshot.data![index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            clipBehavior: Clip.antiAlias,
                            child: BookTile(book: book),
                          );
                        },
                      )
                    ],
                  ),
                ),
                CustomPaint(
                  size: Size(width, topBarHeight),
                  painter: SmallCurve(),
                  child: appBar(
                    'Books',
                    topBarHeight,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No books found'),
            ); // Initial state
          }
        },
      ),
    );
  }

  // Widget _buildLeadingIcon(Book book) {
  //   return Obx(() {
  //     if (_booksController.isDownloading.value) {
  //       return CustomPaint(
  //         painter: CirclePaint(_booksController.progress.value),
  //       );
  //     } else if (_booksController.isBookDownloaded(book.name!)) {
  //       return const Icon(Icons.file_open);
  //     } else {
  //       return const Icon(Icons.file_download);
  //     }
  //   });
  // }
}
