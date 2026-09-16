import 'package:flutter/material.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Pocinui'),
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Center(
              child: Icon(Icons.school, size: 90, color: Colors.blue),
            ),

            const SizedBox(height: 30),

            const Text(
              'Tentang Pocinui',

              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            const Text(
              'Pocinui merupakan bimbingan belajar yang baru '
              'berdiri tahun ini dengan tujuan membantu siswa '
              'belajar secara lebih nyaman, terarah, dan mudah dipahami.',

              style: TextStyle(fontSize: 16, height: 1.6),
            ),

            const SizedBox(height: 30),

            const Text(
              'Visi',

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Menjadi bimbingan belajar yang membantu siswa '
              'memahami pelajaran dengan metode yang sederhana, '
              'efektif, dan menyenangkan.',

              style: TextStyle(fontSize: 16, height: 1.6),
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [
                    Text(
                      'Komitmen Kami',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Meskipun masih baru, Pocinui akan terus '
                      'meningkatkan kualitas guru, materi, dan '
                      'pelayanan pembelajaran.',
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
