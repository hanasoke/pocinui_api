import 'package:flutter/material.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final pesanController = TextEditingController();

  String? subjek;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    pesanController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hubungi Pocinui'),
        backgroundColor: Colors.amber,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Kirim Pesan',

              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Punya pertanyaan mengenai program, '
              'jadwal, guru, atau pendaftaran?',
            ),

            const SizedBox(height: 30),

            TextField(
              controller: namaController,

              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,

              keyboardType: TextInputType.emailAddress,

              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: hpController,

              keyboardType: TextInputType.phone,

              decoration: const InputDecoration(
                labelText: 'Nomor HP / WhatsApp',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: subjek,

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
            ),

            const SizedBox(height: 16),

            TextField(
              controller: pesanController,

              maxLines: 5,

              decoration: const InputDecoration(
                labelText: 'Pesan',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Fitur pengiriman akan dihubungkan ke Laravel API.',
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.send),

                label: const Text('Kirim Pesan'),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Informasi Kontak',

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            const ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text('Alamat'),
              subtitle: Text(
                'Jalan Sirojul Munir, Ruko Hanagakure, '
                'Jatiasih, Kota Bekasi, Jawa Barat.',
              ),
            ),

            const ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('Email'),
              subtitle: Text('infopocinui@pocinui.com'),
            ),

            const ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('WhatsApp'),
              subtitle: Text('085199679134'),
            ),
          ],
        ),
      ),
    );
  }
}
