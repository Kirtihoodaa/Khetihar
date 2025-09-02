import 'package:flutter/material.dart';
import 'package:khetihar/Components/SecondaryAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class SeedsPage extends StatefulWidget {
  const SeedsPage({super.key});

  @override
  State<SeedsPage> createState() => _SeedsPageState();
}

class _SeedsPageState extends State<SeedsPage> {
  final int itemsPerPage = 8;
  int currentPage = 1;

  // ---- DUMMY DATA ----
  final List<Map<String, String>> categories = const [
    {"image": "Assets/Seeds/Cereal.png", "title": "Cereal Seeds"},
    {"image": "Assets/Seeds/Vegetable.png", "title": "Vegetable Seeds"},
    {"image": "Assets/Seeds/OilSeed.png", "title": "Oilseed Crops"},
    {"image": "Assets/Seeds/Fruit.png", "title": "Fruit Seeds"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Pulse SeedS"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Spices & Medicinal"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Fibre Crops"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Fodder Crops"},
  ];

  final List<Map<String, String>> products = List.generate(
    30,
    (i) => {
      "image": "Assets/Seeds/rice.png",
      "title": ["Wheat", "Rice", "Maize", "Barley"][i % 4],
      "desc": "High yield, disease-resistant… item #${i + 1}",
      "price": "INR ${120 + (i % 5) * 10}",
    },
  );

  @override
  Widget build(BuildContext context) {
    final totalPages = (products.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, products.length);
    final pageItems = products.sublist(start, end);

    // 2 columns on phones; you can tweak if you want adaptive
    const crossAxisCount = 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.secondarygrey,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search For Seeds",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: secondary(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.green,
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Categories
            Text(
              "Seeds Categories",
              style: TextStyle(
                fontSize: primary(),
                fontWeight: FontWeight.w600,
                color: AppColors.green,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemBuilder:
                  (ctx, i) => CategoryItem(
                    image: categories[i]['image']!,
                    title: categories[i]['title']!,
                  ),
            ),

            const SizedBox(height: 24),

            // Products (only the current page slice)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pageItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final p = pageItems[index];
                return ProductCard(
                  image: p['image']!,
                  title: p['title']!,
                  desc: p['desc']!,
                  price: p['price']!,
                );
              },
            ),

            // 🔸 Pagination (NON-STICKY) — sits right after items
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(totalPages, (i) {
                  final num = i + 1;
                  final selected = num == currentPage;
                  return GestureDetector(
                    onTap: () => setState(() => currentPage = num),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.green : Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "$num",
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// Category Item
class CategoryItem extends StatelessWidget {
  final String image;
  final String title;
  const CategoryItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: medium(), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

/// Product Card
class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final String price;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image with heart icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: tertiary(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: medium(),
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: tertiary(),
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      "4.4 (124)",
                      style: TextStyle(
                        fontSize: medium(),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.green,
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
