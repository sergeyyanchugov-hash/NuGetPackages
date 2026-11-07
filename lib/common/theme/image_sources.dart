abstract class ImageSources {
  static String getPackageIcon(String? iconUrl) {
    if (iconUrl != null && iconUrl.isNotEmpty) {
      return iconUrl;
    }
    return '';
  }
}
