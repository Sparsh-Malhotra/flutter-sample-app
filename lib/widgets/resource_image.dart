import 'package:flutter/material.dart';

class ResourceImage extends StatelessWidget {
  const ResourceImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(src);
  }
}
