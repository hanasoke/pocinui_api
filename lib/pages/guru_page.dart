import 'package:flutter/material.dart';

class GuruPage extends StatelessWidget {
  const GuruPage({super.key});

  @override
  Widget build(BuildContext context) {
    final guru = [
      {
        'nama': 'Arif Budi Setiawan, S.Pd.',
        'mapel': 'Bahasa Indonesia',
        'icon': Icons.menu_book,
      },

      {
        'nama': 'Mrs. Sinta Utami, S.Pd.',
        'mapel': 'Bahasa Inggris',
        'icon': Icons.language,
      },

      {
        'nama': 'Ibu Nadia Lestari, S.Si.',
        'mapel': 'Biologi',
        'icon': Icons.biotech,
      },

      {
        'nama': 'Ibu Ajeng Lestika Sari, S.E.',
        'mapel': 'Ekonomi',
        'icon': Icons.account_balance,
      },

      {
        'nama': 'Bapak Andi Saputra, S.Pd.',
        'mapel': 'Fisika',
        'icon': Icons.science,
      },

      {
        'nama': 'Bapak Bahrudin Umar, S.Pd.',
        'mapel': 'Geografi',
        'icon': Icons.public,
      },

      {
        'nama': 'Ibu Maha Putri, S.Si.',
        'mapel': 'Kimia',
        'icon': Icons.science_outlined,
      },

      {
        'nama': 'Bapak Fajar Nugroho, S.Pd.',
        'mapel': 'Matematika',
        'icon': Icons.calculate,
      },

      {
        'nama': 'Bapak Listyo Edi Prabowo, S.Pd.',
        'mapel': 'Pendidikan Pancasila',
        'icon': Icons.flag,
      },

      {
        'nama': 'Ibu Nurul Febriati, S.Sos.',
        'mapel': 'Sosiologi',
        'icon': Icons.groups,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guru Pocinui'),
        backgroundColor: Colors.amber,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: guru.length,

        itemBuilder: (context, index) {
          final item = guru[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(
              contentPadding: const EdgeInsets.all(16),

              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,

                child: Icon(item['icon'] as IconData, color: Colors.blue),
              ),

              title: Text(
                item['nama'] as String,

                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(item['mapel'] as String),

              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
