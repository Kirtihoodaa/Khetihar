import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart'; // for audio player
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final _audioPlayer = AudioPlayer();

  // dummy related news (you can fetch from API later)
  final List<Map<String, String>> relatedNews = [
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
      "time": "8 Hours Ago",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setUrl(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', // replace with real audio URL
      );
    } catch (e) {
      debugPrint("Audio load error: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "Assets/NewsTrends/basket.png", // replace with your image
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                "Corn yields expected to increase by 15% this season",
                style: TextStyle(
                  fontSize: primary(),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),

              // Date
              Text(
                "June 15, 2023",
                style: TextStyle(fontSize: tertiary(), color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),

              // Audio Player
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final playing = playerState?.playing;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // 👈 grey container
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Play / Pause button
                        IconButton(
                          icon: Icon(
                            playing == true ? Icons.pause : Icons.play_arrow,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            if (playing == true) {
                              _audioPlayer.pause();
                            } else {
                              _audioPlayer.play();
                            }
                          },
                        ),

                        // Progress bar
                        Expanded(
                          child: StreamBuilder<Duration>(
                            stream: _audioPlayer.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              final duration =
                                  _audioPlayer.duration ?? Duration.zero;

                              return ProgressBar(
                                progress: position,
                                total: duration,
                                onSeek: (d) => _audioPlayer.seek(d),
                                progressBarColor: AppColors.green,
                                baseBarColor: Colors.grey.shade400,
                                thumbColor: AppColors.green,
                                timeLabelLocation: TimeLabelLocation.sides,
                                timeLabelTextStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),

                        // Volume button
                        IconButton(
                          icon: const Icon(
                            Icons.volume_up,
                            color: Colors.black87,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Article Content
              _buildParagraph(
                "Agricultural experts are projecting a significant increase in corn yields across the Midwest this season, with estimates suggesting a 15% growth compared to last year’s harvest...",
              ),
              _buildParagraph(
                "The National Agricultural Survey indicates that this year’s perfect combination of adequate rainfall and moderate temperatures has created ideal growing conditions...",
              ),
              _buildParagraph(
                "“We’re seeing some of the healthiest corn crops in decades,” said Dr. Robert Miller, agricultural scientist at Midwest Agricultural Research Center...",
              ),

              // Subtitle
              Text(
                "Technology Driving Growth",
                style: TextStyle(
                  fontSize: secondary(),
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: 8),

              _buildParagraph(
                "Beyond favorable weather, the implementation of precision agriculture technologies has played a significant role in the projected yield increase...",
              ),
              _buildParagraph(
                "The Department of Agriculture reports that farmers using these advanced techniques have seen an average 23% improvement in efficiency...",
              ),
              _buildParagraph(
                "Market analysts predict this substantial increase in yields will help stabilize corn prices...",
              ),

              const SizedBox(height: 24),

              // Related News Section
              Text(
                "Related News",
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: primary(),
                ),
              ),
              const SizedBox(height: 12),

              Column(
                children:
                    relatedNews
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: TextStyle(
          fontSize: tertiary(),
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }
}

// Reusable NewsCard (copied from NewsScreen)
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
                      Text(
                        "Read More",
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
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
