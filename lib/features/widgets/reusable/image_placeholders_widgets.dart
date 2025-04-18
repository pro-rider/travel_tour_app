import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImagePlaceholder({
    super.key,
    required this.imageUrl,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error, size: 50);
      },
    );
  }
}
