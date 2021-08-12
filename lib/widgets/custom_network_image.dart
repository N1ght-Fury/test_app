import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: url,
      child: Image.network(
        url,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!.toDouble() : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
