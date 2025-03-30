

import 'package:url_launcher/url_launcher.dart';
import 'custom_toast.dart';

class CustomUrlLauncher {

  static Future<void> urlTelLauncher({required String phone}) async {
    try {
      final Uri launchUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        CustomToast.fireToast("Telefon raqamiga qo‘ng‘iroq qilib bo‘lmadi");
      }
    } catch (e) {
      CustomToast.fireToast("Xatolik: Telefon qo‘ng‘irog‘i ishlamadi ($e)");
    }
  }

  // Email uchun
  static Future<void> urlEmailLauncher({required String mail}) async {
    try {
      final Uri launchUri = Uri(scheme: 'mailto', path: mail);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        CustomToast.fireToast("Email yuborib bo‘lmadi");
      }
    } catch (e) {
      CustomToast.fireToast("Xatolik: Email ishlamadi ($e)");
    }
  }

  // Telegram uchun
  static Future<void> urlTelegramLauncher({required String telegramUrl}) async {
    try {
      final Uri launchUri = Uri.parse(telegramUrl);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        CustomToast.fireToast("Telegram ochib bo‘lmadi");
      }
    } catch (e) {
      CustomToast.fireToast("Xatolik: Telegram ishlamadi ($e)");
    }
  }

  // Veb-sayt uchun
  static Future<void> urlWebLauncher({required String webUrl}) async {
    try {
      final Uri launchUri = Uri.parse(webUrl);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        CustomToast.fireToast("Veb-sayt ochib bo‘lmadi");
      }
    } catch (e) {
      CustomToast.fireToast("Xatolik: Veb-sayt ishlamadi ($e)");
    }
  }
}