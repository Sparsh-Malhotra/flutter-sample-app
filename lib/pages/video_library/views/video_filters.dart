import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/app_contants.dart';
import 'package:pathshala/pages/books/controllers/books_controller.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';
import 'package:pathshala/widgets/buttons/large_button.dart';

class VideoFiltersModal extends StatelessWidget {
  VideoFiltersModal({super.key, required this.onApply});

  final void Function(String? bhaagId, String? category) onApply;

  final RxnString category = RxnString(null);
  final RxnString bhaag = RxnString(null);

  final _booksController = Get.put(BooksController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            builder: (BuildContext context) => FutureBuilder(
                  future: _booksController.getBooksHandler(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: width,
                        height: height * 0.55,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                        width: width,
                        height: height * 0.55,
                        child: const Center(
                          child: Text('No bhaags found'),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Container(
                        width: width,
                        height: height * 0.55,
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Align(
                              child: Text(
                                'Apply Filters',
                                style: AppTextStyle.boldBlack20,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Select Bhaag',
                              style: AppTextStyle.mediumBlack18,
                            ),
                            CustomDropdown<String>(
                              hintText: '',
                              initialItem: bhaag.value != null
                                  ? snapshot.data!
                                      .where((element) =>
                                          element.id.toString() == bhaag.value)
                                      .toList()[0]
                                      .name
                                  : null,
                              items:
                                  snapshot.data!.map((e) => e.name!).toList(),
                              onChanged: (value) {
                                category.value = snapshot.data!
                                    .where((element) => element.name == value)
                                    .toList()[0]
                                    .id
                                    .toString();
                              },
                              closedBorder: Border.all(
                                color: AppColors.primarySplash,
                              ),
                              expandedBorder: Border.all(
                                color: AppColors.primary,
                              ),
                              closedBorderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              expandedBorderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              closedFillColor: Colors.transparent,
                              hintBuilder: (ctx, text) => Text(text),
                              headerBuilder: (ctx, text) => Text(
                                text,
                                style: AppTextStyle.regularBlack16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Select Category',
                              style: AppTextStyle.mediumBlack18,
                            ),
                            CustomDropdown<String>(
                              hintText: '',
                              items: categoryOptions,
                              onChanged: (value) {
                                category.value = value;
                              },
                              closedBorder: Border.all(
                                color: AppColors.primarySplash,
                              ),
                              expandedBorder: Border.all(
                                color: AppColors.primary,
                              ),
                              closedBorderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              expandedBorderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              closedFillColor: Colors.transparent,
                              hintBuilder: (ctx, text) => Text(text),
                              headerBuilder: (ctx, text) => Text(
                                text,
                                style: AppTextStyle.regularBlack16,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 50,
                              width: width,
                              child: LargeButton(
                                text: 'Apply',
                                onPress: () {
                                  Get.back();
                                  onApply(bhaag.value, category.value);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No videos found'),
                      );
                    }
                  },
                ));
      },
      icon: const Icon(Icons.filter_alt),
      color: AppColors.white,
    );
  }
}
