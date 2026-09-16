import 'package:flutter/material.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program Belajar'),
        backgroundColor: Colors.amber,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: const [
          ProgramCard(
            title: 'Program SD',
            description: 'Program belajar untuk siswa Sekolah Dasar.',
            icon: Icons.child_care,
          ),

          ProgramCard(
            title: 'Program SMP',
            description: 'Pendampingan belajar untuk siswa SMP.',
            icon: Icons.school,
          ),

          ProgramCard(
            title: 'Program SMA',
            description: 'Program SMA dan persiapan menuju perguruan tinggi.',
            icon: Icons.workspace_premium,
          ),
        ],
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ProgramCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            Icon(icon, size: 50, color: Colors.blue),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

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
