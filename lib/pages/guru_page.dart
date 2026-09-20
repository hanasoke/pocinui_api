import 'package:flutter/material.dart';

import '../models/guru.dart';
import '../services/api_service.dart';
import 'detail_guru_page.dart';

class GuruPage extends StatefulWidget {
  const GuruPage({super.key});

  @override
  State<GuruPage> createState() => _GuruPageState();
}

class _GuruPageState extends State<GuruPage> {
  late Future<List<Guru>> futureGuru;

  @override
  void initState() {
    super.initState();

    futureGuru = ApiService.getGuru();
  }

  Future<void> refreshGuru() async {
    setState(() {
      futureGuru = ApiService.getGuru();
    });

    await futureGuru;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guru Pocinui',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),

      body: RefreshIndicator(
        onRefresh: refreshGuru,

        child: FutureBuilder<List<Guru>>(
          future: futureGuru,

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return ListView(
                children: [
                  const SizedBox(height: 150),

                  const Icon(Icons.cloud_off, size: 70, color: Colors.grey),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'Gagal mengambil data guru.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),

                    child: Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futureGuru = ApiService.getGuru();
                        });
                      },

                      child: const Text('Coba Lagi'),
                    ),
                  ),
                ],
              );
            }

            final gurus = snapshot.data ?? [];

            if (gurus.isEmpty) {
              return const Center(child: Text('Belum ada data guru.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: gurus.length,

              itemBuilder: (context, index) {
                final guru = gurus[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),

                  clipBehavior: Clip.antiAlias,

                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) => DetailGuruPage(guru: guru),
                        ),
                      );
                    },

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // FOTO
                        if (guru.fotoUrl != null)
                          Image.network(
                            guru.fotoUrl!,
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 220,
                                color: Colors.grey.shade200,

                                child: const Icon(Icons.person, size: 80),
                              );
                            },
                          ),

                        Padding(
                          padding: const EdgeInsets.all(16),

                          child: Row(
                            children: [
                              // ICON MAPEL
                              if (guru.iconUrl != null)
                                Image.network(
                                  guru.iconUrl!,
                                  width: 45,
                                  height: 45,

                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.school, size: 40);
                                  },
                                ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      guru.namaLengkap,

                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      guru.mataPelajaran,

                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(Icons.arrow_forward_ios, size: 18),
                            ],
                          ),
                        ),

                        if (guru.deskripsi != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),

                            child: Text(
                              guru.deskripsi!,
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
