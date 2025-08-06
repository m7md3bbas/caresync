import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  const CustomCachedImageNetwork({
    super.key,
    required this.image,
    required this.width,
    required this.height,
  });
  final String image;
  final int width;
  final int height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: 50,
      width: 50,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      placeholder: (context, url) => const CircularProgressIndicator(),
    );
  }
}
