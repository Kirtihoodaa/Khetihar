import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/splash_setup/language_grid.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class UpdateLanguageScreen extends StatefulWidget {
  const UpdateLanguageScreen({super.key});

  @override
  State<UpdateLanguageScreen> createState() => _UpdateLanguageScreenState();
}

class _UpdateLanguageScreenState extends State<UpdateLanguageScreen> {
  int? _selected;

  void _onUpdate() {
    if (_selected == null) return;
    final chosen = languages[_selected!];
    final box = GetStorage();
    box.write('lang', chosen.key);
    Get.updateLocale(chosen.locale);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(title: "Language "),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select The Application Language",
                style: TextStyle(
                  fontSize: primary(),
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LanguageGrid(
                  selectedIndex: _selected,
                  onSelected: (i) => setState(() => _selected = i),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selected == null ? null : _onUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    "Update Language",
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
