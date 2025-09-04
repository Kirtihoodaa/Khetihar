import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// ---------------- MODEL ----------------
class AppLanguage {
  final String code;
  final String country;
  final String title;
  final String native;
  const AppLanguage({
    required this.code,
    required this.country,
    required this.title,
    required this.native,
  });

  Locale get locale => Locale(code, country);
  String get key => '${code}_$country';
}

// ---------------- LANGUAGES ----------------
const languages = <AppLanguage>[
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

// ---------------- GRID ----------------
class LanguageGrid extends StatelessWidget {
  final int? selectedIndex;
  final Function(int) onSelected;

  const LanguageGrid({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 4),
      itemCount: languages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.6,
        mainAxisSpacing: 22,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = languages[index];
        final selected = index == selectedIndex;
        return _LangChip(
          native: item.native,
          title: item.title,
          selected: selected,
          onTap: () => onSelected(index),
        );
      },
    );
  }
}

// ---------------- CHIP ----------------
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
    final bg = selected ? AppColors.green : AppColors.grey;
    final fg = selected ? Colors.white : const Color(0xFF202328);
    final singleLine = native.trim() == title.trim();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(38),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.green.withOpacity(0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Center(
              child: singleLine
                  ? Text(
                      native,
                      style: TextStyle(
                        fontSize: secondary(),
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          native,
                          style: TextStyle(
                            fontSize: secondary(),
                            fontWeight: FontWeight.w700,
                            color: fg,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: tertiary(),
                            fontWeight: FontWeight.w500,
                            color: fg.withOpacity(0.9),
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
