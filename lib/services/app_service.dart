import 'dart:io'; // For checking internet connection
import 'package:html/parser.dart'; // For parsing HTML
import 'package:html_unescape/html_unescape.dart'; // For unescaping HTML entities
import 'package:reading_time/reading_time.dart'; // For calculating reading time

class AppService {
  // Function to check if the device has an active internet connection
  Future<bool?> checkInternet() async {
    bool? internet;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Internet connection available
        internet = true;
      }
    } on SocketException catch (_) {
      // No internet connection
      internet = false;
    }
    return internet;
  }

  // Method to unescape HTML entities and get normal text from a raw HTML string
  static String getNormalText(String text) {
    return HtmlUnescape().convert(parse(text).documentElement!.text);
  }

  // Method to calculate the estimated reading time of a given text
  static String getReadingTime(String text) {
    var reader = readingTime(getNormalText(text));
    return reader.msg;
  }
}
