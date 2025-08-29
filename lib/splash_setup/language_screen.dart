import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';
       // <-- sizes
import '../SplashScreen/OnBording.dart';

class AppLanguage {
  final String code;    // 'en'
  final String country; // 'US'
  final String title;   // English
  final String native;  // English/हिंदी/...
  const AppLanguage({
    required this.code,
    required this.country,
    required this.title,
    required this.native,
  });

  Locale get locale => Locale(code, country);
  String get key => '${code}_$country';
}

// ordered like the screenshot
const _languages = <AppLanguage>[
  AppLanguage(code: 'en', country: 'US', title: 'English', native: 'English'),
  AppLanguage(code: 'hi', country: 'IN', title: 'Hindi', native: 'हिंदी'),
  AppLanguage(code: 'ta', country: 'IN', title: 'Tamil', native: 'தமிழ்'),
  AppLanguage(code: 'ml', country: 'IN', title: 'Malayalam', native: 'മലയാളം'),
  AppLanguage(code: 'ne', country: 'NP', title: 'Nepali', native: 'नेपाली'),
  AppLanguage(code: 'kn', country: 'IN', title: 'Kannada', native: 'ಕನ್ನಡ'),
  AppLanguage(code: 'te', country: 'IN', title: 'Telugu', native: 'తెలుగు'),
  AppLanguage(code: 'gu', country: 'IN', title: 'Gujarati', native: 'ગુજરાતી'),
  AppLanguage(code: 'bn', country: 'IN', title: 'Bengali', native: 'বাংলা'),
  AppLanguage(code: 'mr', country: 'IN', title: 'Marathi', native: 'मराठी'),
  AppLanguage(code: 'ur', country: 'IN', title: 'Urdu', native: 'اُردُو'),
  AppLanguage(code: 'as', country: 'IN', title: 'Assamese', native: 'অসমীয়া'),
  AppLanguage(code: 'sa', country: 'IN', title: 'Sanskrit', native: 'संस्कृतम्'),
];

class LanguageScreen extends StatefulWidget {
  static const String route = '/language';
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int? _selected;

  void _onNext() {
    if (_selected == null) return;
    final chosen = _languages[_selected!];
    final box = GetStorage();
    box.write('lang', chosen.key);
    Get.updateLocale(chosen.locale);
    Get.offAll(
          () => OnboardingScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Title exactly like the image: left-aligned, green, medium weight
    final titleStyle = TextStyle(
      fontSize: primary(),
      fontWeight: FontWeight.w600,
      color: AppColors.green,
      height: 1.25,
    );

    return Scaffold(
      // Page bg is white in your screenshot
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top title
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text('Select The Application Language', style: titleStyle),
                // If you're using i18n, keep this instead:
                // child: Text('choose_language_title'.tr, style: titleStyle),
              ),
               SizedBox(height: 12,),
              // grid of pill chips
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 4),
                  itemCount: _languages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.6, // wide pill shape
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final item = _languages[index];
                    final selected = index == _selected;
                    return _LangChip(
                      native: item.native,
                      title: item.title,
                      selected: selected,
                      onTap: () => setState(() => _selected = index),
                    );
                  },
                ),
              ),

              // Next button pinned at bottom with big radius
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selected == null ? null : _onNext,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.disabled)) {
                        return AppColors.green.withOpacity(0.45);
                      }
                      return AppColors.green;
                    }),
                    foregroundColor:
                    WidgetStateProperty.all<Color>(Colors.white),
                    elevation: WidgetStateProperty.all<double>(0),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    overlayColor: WidgetStateProperty.all<Color>(
                      Colors.white.withOpacity(0.08),
                    ),
                  ),
                  child: Text(
                    'Next', // or 'next'.tr
                    style: TextStyle(
                      fontSize: tertiary(),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String native;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _LangChip({
    required this.native,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // In your image, unselected chips are light grey fills; page is white.
    final bg = selected ? AppColors.green : AppColors.grey;       // #F7F8F9
    final fg = selected ? Colors.white : const Color(0xFF202328);
    final border = selected
        ? BorderSide(color: AppColors.green, width: 1.0)
        : const BorderSide(color: AppColors.greyBorder, width: 1.0);

    final singleLine = native.trim() == title.trim();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(38),
        //border: Border.fromBorderSide(border),
        boxShadow: selected
            ? [
          BoxShadow(
            color: AppColors.green.withOpacity(0.22),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ]
            : const [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          splashColor: selected
              ? Colors.grey.withOpacity(0.30)
              : AppColors.green.withOpacity(0.06),
          child: Padding(
            // slightly taller pills like your layout
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Center(
              child: singleLine
              // “English” shows as a single line in your screenshot
                  ? Text(
                native,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: secondary(),          // 16
                  fontWeight: FontWeight.w700,    // bold
                  color: fg,
                  height: 1.15,
                ),
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    native,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: secondary(),        // 16
                      fontWeight: FontWeight.w700,  // bold top line
                      color: fg,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: tertiary(),         // 14
                      fontWeight: FontWeight.w500,  // lighter bottom line
                      color: fg.withOpacity(0.9),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
