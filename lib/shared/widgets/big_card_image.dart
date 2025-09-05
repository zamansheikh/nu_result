import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'scalton/big_card_image_slide_scalton.dart';

class BigCardImage extends StatelessWidget {
  const BigCardImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => BigCardImageSlideScalton(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
