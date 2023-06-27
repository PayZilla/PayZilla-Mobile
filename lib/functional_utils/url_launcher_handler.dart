import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHandler {
  static Future<void> launchUrlHandler(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch');
    }
  }
}
