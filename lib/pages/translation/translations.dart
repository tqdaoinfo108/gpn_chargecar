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
        'jp_JP': {
          'home': '家',
          'history': "歴史",
          'notification': "通知",
          'setting': "設定",
          'dark_mode': 'ダークモード',
          'light': 'ライト',
          'dark': '暗い',
        }
      };
}
