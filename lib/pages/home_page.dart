import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pocinui',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),

              decoration: const BoxDecoration(color: Colors.blue),

              child: const Column(
                children: [
                  Icon(Icons.school, size: 80, color: Colors.white),

                  SizedBox(height: 20),

                  Text(
                    'Belajar Lebih Mudah Bersama Pocinui',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Bimbingan belajar untuk membantu siswa '
                    'memahami pelajaran dengan lebih mudah, '
                    'nyaman, dan menyenangkan.',
                    textAlign: TextAlign.center,

                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(20),

              child: Column(
                children: [
                  Text(
                    'Mengapa Memilih Pocinui?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 20),

                  FeatureCard(
                    icon: Icons.person,
                    title: 'Guru Berkualitas',
                    description:
                        'Belajar bersama guru sesuai bidang mata pelajaran.',
                  ),

                  FeatureCard(
                    icon: Icons.menu_book,
                    title: 'Materi Lengkap',
                    description:
                        'Materi disusun secara terstruktur dan mudah dipahami.',
                  ),

                  FeatureCard(
                    icon: Icons.sentiment_satisfied,
                    title: 'Belajar Nyaman',
                    description:
                        'Suasana belajar yang nyaman dan menyenangkan.',
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

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            Icon(icon, size: 45, color: Colors.blue),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
