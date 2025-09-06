import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/HomePages/BuySeeds/BuySeeds.dart';
import 'package:khetihar/HomePages/FretiliserAndPest/FertiliserAndPest.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/FontSize.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black87,
                  size: 22,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'New Delhi, India',
                    style: TextStyle(
                      fontSize: secondary(),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 25,
                  color: Colors.black87,
                ),
              ],
            ),

            SizedBox(height: 10),

            // Register banner
            _RegisterBanner(onRegister: () {}),

            const SizedBox(height: 18),

            // Our Services
            Text(
              'Our Services',
              style: TextStyle(
                fontSize: secondary(),
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _ServiceChip(
                    icon: Icons.eco_outlined,
                    label: 'Buy Seeds',
                    color: Color(0xFF16A34A),
                    onTap: () {
                      Get.to(() => SeedsPage());
                    },
                  ),
                  _ServiceChip(
                    icon: Icons.science_outlined,
                    label: 'Fert & Pest',
                    color: Color(0xFF2563EB),
                    onTap: () {
                      Get.to(() => FertilizerAndPest());
                    },
                  ),
                  _ServiceChip(
                    icon: Icons.handyman_outlined,
                    label: 'Agri Tools',
                    color: Color(0xFFEA580C),
                  ),
                  _ServiceChip(
                    icon: Icons.biotech_outlined,
                    label: 'Soil Health',
                    color: Color(0xFF9333EA),
                  ),
                  _ServiceChip(
                    icon: Icons.wb_cloudy_outlined,
                    label: 'Weather',
                    color: AppColors.lightGreen,
                  ),
                  _ServiceChip(
                    icon: Icons.badge_outlined,
                    label: 'Crop Health',
                    color: AppColors.lightGreen,
                  ),
                  _ServiceChip(
                    icon: Icons.storefront_outlined,
                    label: 'Market Place',
                    color: AppColors.lightGreen,
                  ),
                  _ServiceChip(
                    icon: Icons.badge_outlined,
                    label: 'Expert Advice',
                    color: AppColors.lightGreen,
                  ),
                  _ServiceChip(
                    icon: Icons.storefront_outlined,
                    label: 'Farmer Selling',
                    color: AppColors.lightGreen,
                  ),
                  _ServiceChip(
                    icon: Icons.payments_outlined,
                    label: 'Farmer Loans',
                    color: AppColors.lightGreen,
                  ),
                  _ServiceChip(
                    icon: Icons.newspaper,
                    label: 'News & Trends',
                    color: AppColors.lightGreen,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Featured Schemes
            Text(
              'Featured Schemes',
              style: TextStyle(
                fontSize: secondary(),
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 168,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _SchemeCard(
                    title: 'PM-Kisan Loan Yojana',
                    subtitle: 'Low interest loans with govt subsidy',
                  ),
                  SizedBox(width: 12),
                  _SchemeCard(
                    title: 'NABARD Support',
                    subtitle: 'Special schemes for rural development',
                  ),
                  SizedBox(width: 12),
                  _SchemeCard(
                    title: 'Crop Insurance',
                    subtitle: 'Secure your crops against natural loss',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Recent Soil Report",
              style: TextStyle(
                fontSize: secondary(),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            _soilReportCard(),

            SizedBox(height: 20),

            // Important Updates
            Text(
              "Important Updates",
              style: TextStyle(
                fontSize: secondary(),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            _updateCard(
              icon: Icons.cloud_outlined,
              iconColor: Colors.blue,
              bgColor: Colors.blue.shade50,
              title: "Heavy rain expected tomorrow",
              subtitle: "Take necessary precautions",
            ),
            const SizedBox(height: 12),

            _updateCard(
              icon: Icons.calendar_today_outlined,
              iconColor: Colors.amber,
              bgColor: Colors.amber.shade50,
              title: "Govt Scheme deadline: 3 days left",
              subtitle: "Apply before Oct 30",
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _soilReportCard() {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.description_outlined,
              size: 28,
              color: AppColors.green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "15 Jun 2023",
                      style: TextStyle(
                        fontSize: secondary(),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Good",
                        style: TextStyle(
                          fontSize: small(),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "East Plot",
                  style: TextStyle(fontSize: tertiary(), color: Colors.black87),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "View",
              style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w600,
                fontSize: tertiary(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Update Card ----------------
  Widget _updateCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: secondary(),
                    //fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: tertiary(), color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Scheme Card ----------------

// ---------------- Register Banner ----------------
class _RegisterBanner extends StatelessWidget {
  final VoidCallback onRegister;
  const _RegisterBanner({required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.darkGreen, AppColors.lightGreen],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            // left circular leaf icon
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.eco, color: AppColors.green, size: 22),
            ),
            const SizedBox(width: 12),
            // text
            Expanded(
              child: Text(
                'Register Now for Free\nSeeds',
                style: TextStyle(
                  fontSize: secondary(),
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            // right pill button (brown)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: CustomButton(
                text: 'Register',
                onPressed: onRegister,
                backgroundColor: AppColors.brown,
                foregroundColor: Colors.white,
                radius: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Service Chip ----------------
class _ServiceChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ServiceChip({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          children: [
            Container(
              width: 55,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColors.greyBorder),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, size: 26, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Scheme Card ----------------
class _SchemeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SchemeCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.fromLTRB(14, 16, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFCAD5C6).withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: primary(),
              fontWeight: FontWeight.w600,
              color: Colors.white,
              //height: 1.2,
            ),
          ),
          SizedBox(height: 8),
          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: tertiary(),
              color: Colors.white,
              //height: 1.35,
            ),
          ),
          SizedBox(height: 20),
          //const Spacer(),
          // CTA
          Row(
            children: [
              Text(
                'View Details',
                style: TextStyle(
                  fontSize: tertiary(),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.arrow_right_alt, size: 20, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
