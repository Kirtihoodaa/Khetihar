// lib/splash/splash_screen.dart
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Theme/AppColors.dart'; // <- your colors file


/// ====== TUNING KNOBS (adjust these only) ======
const int kTotalMs = 2600; // overall duration (↑ to make everything slower)
const double kRevealDelay = 0.0; // 0 = reveal starts immediately
const double kRevealSpan =
    0.95; // fraction of timeline used by reveal (0..1). ↑ feels longer
const double kRevealPow = 1.55; // >1 = slower start, <1 = faster start
const Curve kRevealCurve = Curves.easeInOutCubic;

const double kLogoOvershoot = 0.015; // subtle logo pop amount
const double kLogoSpan = 0.33; // fraction of timeline for logo pop
const int kHoldMs = 80; // small hold after anim (0..120 ok)
/// ===============================================

class SplashScreen extends StatefulWidget {
  // static const String route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _revealBase;
  late final Animation<double> _shadowT;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: kTotalMs),
    );

    // Reveal timing window — starts immediately, lasts most of the timeline
    _revealBase = CurvedAnimation(
      parent: _c,
      curve: Interval(
        kRevealDelay.clamp(0.0, 1.0),
        (kRevealDelay + kRevealSpan).clamp(0.0, 1.0),
        curve: kRevealCurve,
      ),
    );

    // Subtle logo pop (no long idle)
    final logoEnd = kLogoSpan.clamp(0.05, 1.0);
    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.94,
          end: 1.0 + kLogoOvershoot,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0 + kLogoOvershoot,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(parent: _c, curve: Interval(0.0, logoEnd)));

    _logoOpacity = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 0.18, curve: Curves.easeOut),
    );

    _shadowT = CurvedAnimation(
      parent: _c,
      curve: Interval(0.0, logoEnd, curve: Curves.easeOut),
    );

    // Navigate as soon as the animation completes (cannot hang)
    _c.addStatusListener((status) async {
      if (status == AnimationStatus.completed && mounted) {
        if (kHoldMs > 0) await Future.delayed(Duration(milliseconds: kHoldMs));
        _routeNext();
      }
    });

    // Start immediately
    _c.forward();
  }

  void _routeNext() {
    try {
      final box = GetStorage();
      final saved = box.read<String>('lang'); // e.g., "en_US"
      if (saved == null) {
        Get.toNamed('/LanguageScreen');

        return;
      }
      final parts = saved.split('_');
      if (parts.length == 2) {
        Get.updateLocale(Locale(parts[0], parts[1]));
      }
      Get.toNamed('/onboarding'
      );
    } catch (_) {
      Get.toNamed('/LanguageScreen');
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final size = MediaQuery.of(context).size;

        // radius to cover screen from center
        final maxR =
            sqrt(size.width * size.width + size.height * size.height) / 2;
        final t = _revealBase.value;
        final shapedT = pow(t, kRevealPow).toDouble(); // slower start
        final radius = lerpDouble(0, maxR, shapedT)!;

        return Scaffold(
          backgroundColor: AppColors.grey, // same as native splash color
          body: CustomPaint(
            painter: _RevealPainter(
              radius: radius,
              center: Offset(
                size.width / 2,
                size.height / 2,
              ), // reveal from exact center
              color: AppColors.green,
            ),
            child: Center(
              child: Opacity(
                opacity: _logoOpacity.value,
                child: Transform.scale(
                  scale: _logoScale.value,
                  child: _LogoBadge(shadowT: _shadowT.value),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RevealPainter extends CustomPainter {
  final double radius;
  final Offset center;
  final Color color;

  _RevealPainter({
    required this.radius,
    required this.center,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final base =
        Paint()
          ..color = AppColors.grey
          ..isAntiAlias = true;
    canvas.drawRect(Offset.zero & size, base);

    final reveal =
        Paint()
          ..color = color
          ..isAntiAlias = true;
    canvas.drawCircle(center, radius, reveal);
  }

  @override
  bool shouldRepaint(covariant _RevealPainter old) =>
      old.radius != radius || old.center != center || old.color != color;
}

class _LogoBadge extends StatelessWidget {
  final double shadowT;
  const _LogoBadge({super.key, required this.shadowT});

  @override
  Widget build(BuildContext context) {
    final blur = lerpDouble(6, 12, shadowT)!;
    final spread = lerpDouble(1, 4, shadowT)!;

    return Container(
      width: 132,
      height: 132,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Colors.white, Color(0xFFF4F4F4)],
          radius: 0.95,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: blur,
            spreadRadius: spread * 0.1,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: const Color(0x1A000000), width: 0.6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset('Assets/HomeScreens/Logo.png', fit: BoxFit.contain),
      ),
    );
  }
}
