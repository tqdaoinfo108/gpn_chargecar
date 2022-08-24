import 'package:get/get.dart';

class LanguageTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home': 'Home',
          'history': "History",
          'notification': "Notification",
          'setting': "Setting",
          'dark_mode': 'Dark mode',
          'light': 'Light',
          'dark': 'Dark',
        },
        'ja_JP': {
          'home': 'HomeJP',
          'history': "HistoryJP",
          'notification': "NotificationJP",
          'setting': "SettingJP",
          'dark_mode': 'DarkJP',
          'light': 'LightJP',
          'dark': 'DarkJP',
        }
      };
}
