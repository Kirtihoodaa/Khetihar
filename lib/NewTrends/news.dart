import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // charts
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Latest News data
    final List<Map<String, String>> latestNews = [
      {
        "image": "Assets/NewsTrends/farm.png",
        "title": "Tech Innovations in Irrigation Systems",
        "desc":
            "Smart irrigation systems using AI to optimize water usage are helping farmers save costs...",
        "time": "5 Hours Ago",
      },
      {
        "image": "Assets/NewsTrends/farm.png",
        "title": "Government Increases MSP for Paddy This Year",
        "desc":
            "Farmers to benefit from higher procurement rates under new policy announced recently...",
        "time": "5 Hours Ago",
      },
    ];

    // Market Trends data (mini chart values)
    final List<Map<String, dynamic>> marketTrends = [
      {
        "name": "Wheat",
        "percent": "+1.2%",
        "price": "+INR 30",
        "positive": true,
        "data": <double>[1, 1.5, 2, 2.2, 2.8, 3.2, 3.5],
      },
      {
        "name": "Corn",
        "percent": "-0.2%",
        "price": "-INR 30",
        "positive": false,
        "data": <double>[3.5, 3.0, 2.8, 2.6, 2.4, 2.1, 2.0],
      },
      {
        "name": "Corn",
        "percent": "-0.2%",
        "price": "-INR 30",
        "positive": false,
        "data": <double>[2.8, 2.5, 2.2, 2.0, 1.9, 1.7, 1.5],
      },
      {
        "name": "Wheat",
        "percent": "+1.2%",
        "price": "+INR 30",
        "positive": true,
        "data": <double>[1, 1.3, 1.7, 2.0, 2.5, 2.8, 3.0],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search
              CustomInputField(
                labelText: "Search news and trends",
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: 16),

              // Tabs
              DefaultTabController(
                length: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      tabAlignment: TabAlignment.start,

                      isScrollable: true,
                      labelColor: AppColors.green,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: AppColors.green,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      tabs: const [
                        Tab(text: "All"),
                        Tab(text: "Farming"),
                        Tab(text: "Fertilizer"),
                        Tab(text: "Crop"),
                        Tab(text: "Irrigation"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Featured banner
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset(
                      "Assets/NewsTrends/basket.png",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Trending",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: tertiary(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "June 15, 2023",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: medium(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Corn yields expected to increase by 15% this season",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: medium(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed('/newsDetail');
                            },
                            child: Text(
                              "Read More",
                              style: TextStyle(fontSize: medium()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Latest News
              Text(
                "Latest News",
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: primary(),
                ),
              ),
              const SizedBox(height: 12),
              Column(
                children:
                    latestNews
                        .map(
                          (news) => NewsCard(
                            imageUrl: news["image"]!,
                            title: news["title"]!,
                            description: news["desc"]!,
                            timeAgo: news["time"]!,
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 20),

              // Market Trends
              Text(
                "Market Trends",
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: secondary(),
                ),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children:
                    marketTrends
                        .map(
                          (item) => _buildMarketCard(
                            item["name"] as String,
                            item["percent"] as String,
                            item["price"] as String,
                            item["positive"] as bool,
                            (item["data"] as List<double>),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Market Card with mini area chart (lighter colors)
  Widget _buildMarketCard(
    String name,
    String percent,
    String price,
    bool positive,
    List<double> data,
  ) {
    final stroke = positive ? Colors.green : AppColors.red;
    final fillColor = positive ? Colors.green : AppColors.red;

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: tertiary(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: stroke.withOpacity(0.15), // lighter background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    percent,
                    style: TextStyle(
                      fontSize: medium(),
                      color: stroke,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(color: stroke, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // mini chart
            SizedBox(
              height: 80,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        data.length,
                        (i) => FlSpot(i.toDouble(), data[i]),
                      ),
                      isCurved: true,
                      color: stroke,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            fillColor.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable News card
class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String timeAgo;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: secondary(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: medium()),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed('/newsDetail'),
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(fontSize: small(), color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
