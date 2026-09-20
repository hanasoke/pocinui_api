import 'package:flutter/material.dart';

import '../models/guru.dart';

class DetailGuruPage extends StatelessWidget {
  final Guru guru;

  const DetailGuruPage({super.key, required this.guru});

  Widget biodata(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 140,

            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Guru'),
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // FOTO
            if (guru.fotoUrl != null)
              Image.network(
                guru.fotoUrl!,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 320,
                    color: Colors.grey.shade200,

                    child: const Center(child: Icon(Icons.person, size: 100)),
                  );
                },
              ),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    guru.namaLengkap,

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      guru.mataPelajaran,

                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Biodata Guru',

                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const Divider(),

                  biodata('Nama', guru.nama),

                  biodata('Gelar', guru.gelar ?? '-'),

                  biodata('Jenis Kelamin', guru.jenisKelamin),

                  biodata(
                    'Usia',
                    guru.usia != null ? '${guru.usia} Tahun' : '-',
                  ),

                  biodata('Mata Pelajaran', guru.mataPelajaran),

                  biodata('Pendidikan', guru.pendidikan ?? '-'),

                  biodata('Universitas', guru.universitas ?? '-'),

                  biodata('Pengalaman', '${guru.pengalaman} Tahun'),

                  const SizedBox(height: 25),

                  const Text(
                    'Tentang Guru',

                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    guru.deskripsi ?? 'Belum ada deskripsi.',

                    style: const TextStyle(fontSize: 16, height: 1.5),
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
