import 'package:flutter/material.dart';

class ClaySoilScreen extends StatelessWidget {
  const ClaySoilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/Soil/soil.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // White rounded container with text
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        "Understanding Clay Soil",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Paragraph
                      const Text(
                        "Clay soil is characterized by its dense, compact texture and small particles. "
                        "While it's nutrient-rich and retains water well, it can be challenging to work with "
                        "due to poor drainage and slow warming in spring. Breaking up compacted clay soil is "
                        "essential for successful planting.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Subtitle
                      Text(
                        "Benefits of Well-Prepared Clay Soil",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Bullet points
                      bulletPoint("Better root penetration and plant growth"),
                      bulletPoint("Improved drainage and reduced waterlogging"),
                      bulletPoint("Enhanced nutrient availability"),
                      bulletPoint("Increased microbial activity"),
                      bulletPoint("More balanced moisture retention"),
                      const SizedBox(height: 16),

                      Text(
                        "Step-by-Step Guide",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      stepTitle("Test your soil"),
                      stepText(
                        "Determine the clay content and pH level before starting any amendments.",
                      ),
                      stepTitle("Clear the area"),
                      stepText(
                        "Remove all weeds, rocks, and debris from the planting area.",
                      ),
                      stepTitle("Add gypsum"),
                      stepText(
                        "Apply agricultural gypsum to help break up clay particles (2–3 lbs per 100 sq ft).",
                      ),
                      stepTitle("Add organic amendments"),
                      stepText(
                        "Mix in compost, aged manure, or leaf mold (4–6 inch layer).",
                      ),
                      stepTitle("Incorporate amendments"),
                      stepText(
                        "Work organic matter into the top 8–12 inches of soil.",
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Best Timing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      stepTitle("Fall – Ideal"),
                      stepText(
                        "Gives amendments time to integrate before spring planting.",
                      ),
                      stepTitle("Winter – Good"),
                      stepText(
                        "Freeze–thaw cycles help break up clay naturally.",
                      ),
                      stepTitle("Spring – Challenging"),
                      stepText("Soil may be too wet to work properly."),
                      stepTitle("Summer – Difficult"),
                      stepText("Soil may be too dry and hard to work."),
                      const SizedBox(height: 16),

                      Text(
                        "Watering Considerations",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      stepText(
                        "Clay soil drains slowly, so water deeply but less frequently. "
                        "Allow the top 1–2 inches to dry out between waterings to prevent waterlogging "
                        "and encourage roots to grow deeper.\n\n"
                        "Ideal watering frequency: 1–2 times per week.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable bullet point widget
  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 16, height: 1.5)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // Step title
  Widget stepTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 2),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  // Step text
  Widget stepText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4)),
    );
  }
}
