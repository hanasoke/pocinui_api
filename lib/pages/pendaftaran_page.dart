import 'package:flutter/material.dart';

import '../models/program.dart';
import '../services/api_service.dart';

class PendaftaranPage extends StatefulWidget {
  final Program program;

  const PendaftaranPage({super.key, required this.program});

  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final noHpController = TextEditingController();
  final sekolahController = TextEditingController();
  final alamatController = TextEditingController();

  String? selectedJenisKelamin;
  String? selectedKelas;

  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    sekolahController.dispose();
    alamatController.dispose();

    super.dispose();
  }

  Future<void> submitPendaftaran() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedJenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih jenis kelamin.')),
      );

      return;
    }

    if (selectedKelas == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih kelas.')));

      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await ApiService.daftarProgram(
      programId: widget.program.id,
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      noHp: noHpController.text.trim(),
      jenisKelamin: selectedJenisKelamin!,
      sekolah: sekolahController.text.trim(),
      kelas: selectedKelas!,
      alamat: alamatController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result['success'] == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Berhasil'),
              ],
            ),

            content: const Text(
              'Pendaftaran program berhasil dikirim. '
              'Silakan tunggu informasi selanjutnya '
              'dari Pocinui.',
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Pendaftaran gagal.')),
      );
    }
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pendaftaran Program',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),

      body: Form(
        key: _formKey,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // PROGRAM YANG DIPILIH
              Card(
                elevation: 2,

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Row(
                    children: [
                      if (widget.program.iconUrl != null)
                        Image.network(
                          widget.program.iconUrl!,
                          width: 50,
                          height: 50,

                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.school, size: 45);
                          },
                        )
                      else
                        const Icon(Icons.school, size: 45),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              'Program yang dipilih',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              widget.program.namaProgram,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              '${widget.program.mataPelajaran} • '
                              '${widget.program.jenjang}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Data Peserta',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              // NAMA
              TextFormField(
                controller: namaController,

                decoration: inputDecoration('Nama Lengkap', Icons.person),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // EMAIL
              TextFormField(
                controller: emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: inputDecoration('Email', Icons.email),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi.';
                  }

                  if (!value.contains('@')) {
                    return 'Format email tidak valid.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // NOMOR HP
              TextFormField(
                controller: noHpController,

                keyboardType: TextInputType.phone,

                decoration: inputDecoration('Nomor HP', Icons.phone),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor HP wajib diisi.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // JENIS KELAMIN
              DropdownButtonFormField<String>(
                value: selectedJenisKelamin,

                decoration: inputDecoration('Jenis Kelamin', Icons.people),

                items: const [
                  DropdownMenuItem(
                    value: 'Laki-laki',
                    child: Text('Laki-laki'),
                  ),

                  DropdownMenuItem(
                    value: 'Perempuan',
                    child: Text('Perempuan'),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedJenisKelamin = value;
                  });
                },
              ),

              const SizedBox(height: 15),

              // SEKOLAH
              TextFormField(
                controller: sekolahController,

                decoration: inputDecoration('Sekolah', Icons.school),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Sekolah wajib diisi.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // KELAS
              DropdownButtonFormField<String>(
                value: selectedKelas,

                decoration: inputDecoration('Kelas', Icons.class_),

                items: const [
                  DropdownMenuItem(value: '4 SD', child: Text('4 SD')),
                  DropdownMenuItem(value: '5 SD', child: Text('5 SD')),
                  DropdownMenuItem(value: '6 SD', child: Text('6 SD')),
                  DropdownMenuItem(value: '7 SMP', child: Text('7 SMP')),
                  DropdownMenuItem(value: '8 SMP', child: Text('8 SMP')),
                  DropdownMenuItem(value: '9 SMP', child: Text('9 SMP')),
                  DropdownMenuItem(value: '10 SMA', child: Text('10 SMA')),
                  DropdownMenuItem(value: '11 SMA', child: Text('11 SMA')),
                  DropdownMenuItem(value: '12 SMA', child: Text('12 SMA')),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedKelas = value;
                  });
                },
              ),

              const SizedBox(height: 15),

              // ALAMAT
              TextFormField(
                controller: alamatController,

                maxLines: 4,

                decoration: inputDecoration('Alamat', Icons.home),
              ),

              const SizedBox(height: 30),

              // TOMBOL DAFTAR
              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed: isLoading ? null : submitPendaftaran,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,

                    foregroundColor: Colors.black,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: isLoading
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  'Data pendaftaran akan dikirim '
                  'ke server Pocinui.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
