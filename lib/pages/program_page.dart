import 'package:flutter/material.dart';

import '../models/program.dart';
import '../services/api_service.dart';
import 'detail_program_page.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({super.key});

  @override
  State<ProgramPage> createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  late Future<List<Program>> futureProgram;

  @override
  void initState() {
    super.initState();

    futureProgram = ApiService.getProgram();
  }

  Future<void> refreshProgram() async {
    setState(() {
      futureProgram = ApiService.getProgram();
    });

    await futureProgram;
  }

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

      body: RefreshIndicator(
        onRefresh: refreshProgram,

        child: FutureBuilder<List<Program>>(
          future: futureProgram,

          builder: (context, snapshot) {
            // LOADING
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ERROR
            if (snapshot.hasError) {
              return ListView(
                children: [
                  const SizedBox(height: 150),

                  const Icon(Icons.cloud_off, size: 70, color: Colors.grey),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'Gagal mengambil data program.',
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
                          futureProgram = ApiService.getProgram();
                        });
                      },

                      child: const Text('Coba Lagi'),
                    ),
                  ),
                ],
              );
            }

            final programs = snapshot.data ?? [];

            // DATA KOSONG
            if (programs.isEmpty) {
              return const Center(child: Text('Belum ada program.'));
            }

            // DATA PROGRAM
            return ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: programs.length,

              itemBuilder: (context, index) {
                final program = programs[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),

                  clipBehavior: Clip.antiAlias,

                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailProgramPage(program: program),
                        ),
                      );
                    },

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // GAMBAR PROGRAM
                        if (program.gambarUrl != null)
                          Image.network(
                            program.gambarUrl!,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,

                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return Container(
                                height: 180,
                                color: Colors.grey.shade200,

                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },

                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                color: Colors.grey.shade200,

                                child: const Icon(
                                  Icons.school,
                                  size: 70,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),

                        Padding(
                          padding: const EdgeInsets.all(16),

                          child: Row(
                            children: [
                              // ICON
                              if (program.iconUrl != null)
                                Image.network(
                                  program.iconUrl!,
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
                                      program.namaProgram,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      program.mataPelajaran,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      program.jenjang,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(Icons.arrow_forward_ios, size: 18),
                            ],
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
