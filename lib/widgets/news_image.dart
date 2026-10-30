import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  const NewsImage({super.key, required this.url, this.borderRadius = 0});

  final String url;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = url.isEmpty
        ? Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported_outlined, size: 35),
          )
        : Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported_outlined, size: 35),
            ),
          );

    if (borderRadius == 0) return image;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );
  }
}
