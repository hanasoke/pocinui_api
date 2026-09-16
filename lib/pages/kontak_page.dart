import 'package:flutter/material.dart';

import '../services/api_service.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final pesanController = TextEditingController();

  String? subjek;

  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    pesanController.dispose();

    super.dispose();
  }

  Future<void> kirimPesan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (subjek == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih subjek.')));

      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await ApiService.kirimKontak(
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      noHp: hpController.text.trim(),
      subjek: subjek!,
      pesan: pesanController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message']),
        backgroundColor: result['success'] ? Colors.green : Colors.red,
      ),
    );

    if (result['success']) {
      namaController.clear();
      emailController.clear();
      hpController.clear();
      pesanController.clear();

      setState(() {
        subjek = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hubungi Pocinui',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Kirim Pesan',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Punya pertanyaan mengenai program belajar, '
                'jadwal, guru, atau pendaftaran? '
                'Silakan hubungi kami.',
              ),

              const SizedBox(height: 30),

              // NAMA
              TextFormField(
                controller: namaController,

                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // EMAIL
              TextFormField(
                controller: emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),

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

              const SizedBox(height: 16),

              // NOMOR HP
              TextFormField(
                controller: hpController,

                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(
                  labelText: 'Nomor HP / WhatsApp',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // SUBJEK
              DropdownButtonFormField<String>(
                value: subjek,

                decoration: const InputDecoration(
                  labelText: 'Subjek',
                  prefixIcon: Icon(Icons.subject),
                  border: OutlineInputBorder(),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'Informasi Program',
                    child: Text('Informasi Program'),
                  ),

                  DropdownMenuItem(
                    value: 'Pendaftaran',
                    child: Text('Pendaftaran'),
                  ),

                  DropdownMenuItem(
                    value: 'Jadwal Belajar',
                    child: Text('Jadwal Belajar'),
                  ),

                  DropdownMenuItem(
                    value: 'Biaya',
                    child: Text('Biaya Bimbingan'),
                  ),

                  DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                ],

                onChanged: (value) {
                  setState(() {
                    subjek = value;
                  });
                },

                validator: (value) {
                  if (value == null) {
                    return 'Subjek wajib dipilih.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // PESAN
              TextFormField(
                controller: pesanController,

                maxLines: 5,

                decoration: const InputDecoration(
                  labelText: 'Pesan',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pesan wajib diisi.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : kirimPesan,

                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),

                  label: Text(isLoading ? 'Mengirim...' : 'Kirim Pesan'),
                ),
              ),

              const SizedBox(height: 40),

              const Divider(),

              const SizedBox(height: 20),

              const Text(
                'Informasi Kontak',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              const Card(
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Colors.red),

                  title: Text('Alamat'),

                  subtitle: Text(
                    'Jalan Sirojul Munir, Ruko Hanagakure, '
                    'RT 02/RW 03, Jatiasih, '
                    'Kota Bekasi, Jawa Barat.',
                  ),
                ),
              ),

              const Card(
                child: ListTile(
                  leading: Icon(Icons.email, color: Colors.blue),

                  title: Text('Email'),

                  subtitle: Text('infopocinui@pocinui.com'),
                ),
              ),

              const Card(
                child: ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),

                  title: Text('WhatsApp'),

                  subtitle: Text('085199679134'),
                ),
              ),

              const Card(
                child: ListTile(
                  leading: Icon(Icons.access_time, color: Colors.orange),

                  title: Text('Jam Operasional'),

                  subtitle: Text('Senin - Jumat\n10.00 - 21.00 WIB'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
