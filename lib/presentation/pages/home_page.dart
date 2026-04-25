import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/aura_cubit.dart';
import '../bloc/aura_state.dart';
import '../widgets/laser_scanner_animation.dart';
import 'leaderboard_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi untuk membuka Galeri iOS bawaan menggunakan ImagePicker
  Future<void> _pickImages(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    
    if (images.isNotEmpty) {
      final paths = images.map((e) => e.path).toList();
      // Memulai proses AI (Cubit -> UseCase -> Swift Engine)
      context.read<AuraCubit>().scanImages(paths);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D12), // Warna latar gelap premium
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Glow & Glassmorphism
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent.withOpacity(0.15),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),

          // Main Content yang diatur oleh Cubit State
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocConsumer<AuraCubit, AuraState>(
                listener: (context, state) {
                  // Jika sukses, lempar ke halaman Leaderboard
                  if (state is AuraSuccess) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LeaderboardPage(results: state.results),
                      ),
                    );
                    
                    // Reset status ke awal agar pas user klik tombol back, aplikasinya siap nge-scan lagi
                    context.read<AuraCubit>().reset();
                    
                  } else if (state is AuraError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}'), backgroundColor: Colors.red),
                    );
                  }
                },
                builder: (context, state) {
                  // Mengubah isi layar 100% tanpa perpindahan halaman berdasarkan State
                  if (state is AuraScanning) {
                    return _buildScanningUI();
                  }
                  
                  return _buildInitialUI(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan awal (Initial State)
  Widget _buildInitialUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        const Icon(Icons.auto_awesome, size: 80, color: Colors.cyanAccent),
        const SizedBox(height: 24),
        const Text(
          "BidadariMeter",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Ukur persentase Aura kecantikan dengan teknologi Apple Vision & Golden Ratio.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => _pickImages(context),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.cyanAccent, Colors.blueAccent],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: const Center(
              child: Text(
                "PILIH FOTO GALERI",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // Tampilan Scanning dengan animasi Laser
  Widget _buildScanningUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "MEMPROSES AURA...",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 3.0,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.3),
          ),
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: LaserScannerAnimation(),
          ),
        ),
        const SizedBox(height: 40),
        const CircularProgressIndicator(color: Colors.cyanAccent),
      ],
    );
  }
}
