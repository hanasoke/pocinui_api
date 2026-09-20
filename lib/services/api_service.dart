import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/guru.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.4:8000/api';

  static Future<Map<String, dynamic>> kirimKontak({
    required String nama,
    required String email,
    required String noHp,
    required String subjek,
    required String pesan,
  }) async {
    final url = Uri.parse('$baseUrl/kontak');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'no_hp': noHp,
          'subjek': subjek,
          'pesan': pesan,
        }),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Pesan berhasil dikirim.',
        };
      }

      if (response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Data yang dimasukkan belum valid.',
          'errors': data['errors'],
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Terjadi kesalahan pada server.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server Laravel.',
      };
    }
  }

  static Future<List<Guru>> getGuru() async {
    final url = Uri.parse('$baseUrl/guru');

    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> data = json['data'];

      return data.map((item) => Guru.fromJson(item)).toList();
    }

    throw Exception(
      'Gagal mengambil data guru. '
      'Status: ${response.statusCode}',
    );
  }
}
