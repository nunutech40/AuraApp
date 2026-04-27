import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/entities/aura_entity.dart';

class LeaderboardPage extends StatelessWidget {
  final List<AuraEntity> results;

  const LeaderboardPage({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "SPEKTRUM PESONA",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: Colors.cyanAccent,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Glow Effect
          Positioned(
            top: 100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber.withOpacity(0.15),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(color: Colors.transparent),
          ),
          
          // List View Animasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final isWinner = index == 0; // Rank 1 (karena list sudah tersortir)
                
                return _buildLeaderboardCard(item, index + 1, isWinner);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper function untuk memberikan label berdasarkan skor
  String _getAuraLabel(double score) {
    if (score >= 95.0) return "Supreme Aura 👑";
    if (score >= 90.0) return "Ethereal Charm ✨";
    if (score >= 80.0) return "Captivating Vibe 💫";
    if (score >= 70.0) return "Pleasant Harmony 🌟";
    return "Unique Signature 🔥";
  }

  // Tampilan Kartu untuk masing-masing foto
  Widget _buildLeaderboardCard(AuraEntity entity, int rank, bool isWinner) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          // Bingkai emas untuk juara 1
          color: isWinner ? Colors.amber : Colors.white.withOpacity(0.1),
          width: isWinner ? 2.0 : 1.0,
        ),
        boxShadow: isWinner
            ? [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Angka Ranking
            SizedBox(
              width: 40,
              child: Text(
                "#$rank",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: isWinner ? Colors.amber : Colors.white54,
                ),
              ),
            ),
            
            // Thumbnail Foto Galeri
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(entity.imagePath),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                // Penanganan jika gambar gagal dirender
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.withOpacity(0.3),
                  child: const Icon(Icons.broken_image, color: Colors.white54),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Area Teks Skor
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getAuraLabel(entity.score),
                    style: TextStyle(
                      color: isWinner ? Colors.amber : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "${entity.score}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        " / 100",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Ikon Tambahan untuk Juara
            if (isWinner)
              const Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 36,
              ),
          ],
        ),
      ),
    );
  }
}
