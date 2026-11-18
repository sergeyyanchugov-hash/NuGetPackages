import 'package:flutter/material.dart';

abstract class ImageSources {
  static String getPackageIcon(String? iconUrl) {
    if (iconUrl != null && iconUrl.isNotEmpty) {
      return iconUrl;
    }
    return '';
  }

  static Widget buildPackageIcon(String? iconUrl, {double size = 48}) {
    if (iconUrl == null || iconUrl.isEmpty) {
      return Icon(Icons.extension, size: size);
    }
    if (iconUrl.startsWith('http://') || iconUrl.startsWith('https://')) {
      return Image.network(
        iconUrl,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.extension, size: size),
      );
    } else {
      return Image.asset(
        iconUrl,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.extension, size: size),
      );
    }
  }
}
