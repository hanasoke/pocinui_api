import 'package:flutter/material.dart';

import '../models/program.dart';
import 'pendaftaran_page.dart';

class DetailProgramPage extends StatelessWidget {
  final Program program;

  const DetailProgramPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Program Pocinui',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // GAMBAR
            if (program.gambarUrl != null)
              Image.network(
                program.gambarUrl!,
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
              ),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    program.namaProgram,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '${program.mataPelajaran} • ${program.jenjang}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Deskripsi Program',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(program.deskripsi ?? 'Belum ada deskripsi.'),

                  const SizedBox(height: 20),

                  const Text(
                    'Jadwal',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(program.jadwal ?? 'Belum tersedia'),

                  const SizedBox(height: 20),

                  const Text(
                    'Harga',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Rp ${program.harga}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PendaftaranPage(program: program),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,

                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),

                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
