import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/guru.dart';
import '../models/program.dart';

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

  static Future<List<Program>> getProgram() async {
    final url = Uri.parse('$baseUrl/program');

    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      print('PROGRAM URL: $url');
      print('PROGRAM STATUS: ${response.statusCode}');
      print('PROGRAM BODY: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil data program. '
          'Status: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> data = json['data'] ?? [];

      return data.map((item) => Program.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil data program: $e');
    }
  }

  static Future<Map<String, dynamic>> daftarProgram({
    required int programId,
    required String nama,
    required String email,
    required String noHp,
    required String jenisKelamin,
    required String sekolah,
    required String kelas,
    required String alamat,
  }) async {
    final url = Uri.parse('$baseUrl/pendaftaran');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'program_id': programId,
          'nama': nama,
          'email': email,
          'no_hp': noHp,
          'jenis_kelamin': jenisKelamin,
          'sekolah': sekolah,
          'kelas': kelas,
          'alamat': alamat,
        }),
      );

      print('PENDAFTARAN URL: $url');
      print('PENDAFTARAN STATUS: ${response.statusCode}');
      print('PENDAFTARAN BODY: ${response.body}');

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return data;
      }

      if (response.statusCode == 422) {
        return {
          'success': false,
          'message': data['message'] ?? 'Data pendaftaran belum valid.',
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
}
