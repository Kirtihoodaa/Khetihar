import 'package:flutter/material.dart';
import 'package:khetihar/Theme/FontSize.dart';

import '../../Components/SecondaryAppBar.dart';
import '../../Theme/AppColors.dart';

class ReviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      "score": 3,
      "time": "2 months ago",
      "text": "Seeds are of high quality and look as shown in the images, packaging and price are also good.",
      "up": 12,
      "down": 12,
    },
    {
      "score": 4,
      "time": "2 months ago",
      "text": "This is exactly what i need for my Farm! The water conservation tips are invaluable. Thanks for sharing",
      "up": 12,
      "down": 12,
    },
    {
      "score": 5,
      "time": "2 months ago",
      "text": "Seeds are of high quality and look as shown in the images, packaging and price are also good.",
      "up": 12,
      "down": 12,
    },
    {
      "score": 2,
      "time": "2 months ago",
      "text": "Seeds are of high quality and look as shown in the images, packaging and price are also good.",
      "up": 12,
      "down": 12,
    },
    {
      "score": 1,
      "time": "2 months ago",
      "text": "Seeds are of high quality and look as shown in the images, packaging and price are also good.",
      "up": 12,
      "down": 12,
    },
  ];

  final List<int> ratingDistribution = [11113, 1113, 5113, 113, 53];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating summary
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Score & meta
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("4.0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: large())),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          ...List.generate(
                              4,
                                  (idx) => Icon(Icons.star, color: Colors.amber, size: 22)),
                          Icon(Icons.star, color: Colors.grey[400], size: 22),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Based on 22,333\nreview and 11,160 ratings",
                        style: TextStyle(color: Colors.grey[700], fontSize: medium()),
                      ),
                    ],
                  ),
                  // Right: Rating distribution
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(5, (idx) {
                          final colorMap = [
                            Colors.green,
                            Colors.green[200],
                            Colors.amber[600],
                            Colors.orange[300],
                            Colors.red
                          ];
                          // Highest value for barPercent calculation
                          final maxVal = ratingDistribution[0].toDouble();
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Text("${5 - idx}", style: TextStyle(fontSize: 14)),
                                const SizedBox(width: 2),
                                Icon(Icons.star, color: colorMap[idx], size: 18),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: ratingDistribution[idx] / maxVal,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(colorMap[idx]!),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                SizedBox(
                                  width: 44,
                                  child: Text(
                                    "${ratingDistribution[idx]}",
                                    style: TextStyle(fontSize: small(), color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Reviews List
              ListView.builder(
                itemCount: reviews.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, idx) {
                  final review = reviews[idx];
                  final colorList = [
                    Colors.green,
                    Colors.green[200],
                    Colors.amber[600],
                    Colors.orange[600],
                    Colors.red
                  ];
                  final score = review["score"] ?? 3;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row of rating + time
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: colorList[5 - (score is int ? score : (score as num).toInt())],
                                borderRadius: BorderRadius.circular(44),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star, size: 16, color: Colors.white),
                                    Text("$score",
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: medium())),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              review["time"],
                              style: TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            const SizedBox(width: 12),
                            Row(
                              children: [
                                ...List.generate(
                                    5,
                                        (starIdx) => Icon(
                                      Icons.star,
                                      size: 18,
                                      color: starIdx < score ? Colors.amber : Colors.grey[300],
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          review["text"],
                          style: TextStyle(fontSize: tertiary(), color: Colors.black),
                        ),
                        // const SizedBox(height: 7),
                        // Row(
                        //   children: [
                        //     Icon(Icons.thumb_up, size: 18, color: Colors.grey[600]),
                        //     const SizedBox(width: 2),
                        //     Text("${review['up']}", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        //     const SizedBox(width: 12),
                        //     Icon(Icons.thumb_down, size: 18, color: Colors.grey[600]),
                        //     const SizedBox(width: 2),
                        //     Text("${review['down']}", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        //   ],
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
