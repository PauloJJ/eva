import 'package:eva/ux/components/show_loading_component.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

openUrlUtil(String url) async {
  showLoadingComponent();

  await launchUrl(Uri.parse(url));

  Get.back();
}

openEmail({required String email, required String message}) async {
  showLoadingComponent();

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: message,
  );

  if (!await launchUrl(emailLaunchUri)) {
    throw 'Could not launch $emailLaunchUri';
  }

  Get.back();
}
