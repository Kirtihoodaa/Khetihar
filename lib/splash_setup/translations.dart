import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'choose_language_title': 'Select The Application Language',
      'choose_language_hint': 'Please select your preferred language',
      'next': 'Next',
    },
    'hi_IN': {
      'choose_language_title': 'एप्लिकेशन की भाषा चुनें',
      'choose_language_hint': 'कृपया अपनी पसंदीदा भाषा चुनें',
      'next': 'आगे',
    },
  };
}
