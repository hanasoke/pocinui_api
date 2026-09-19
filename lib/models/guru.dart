class Guru {
  late final int id;
  late String slug;
  late final String nama;
  late String? gelar;
  late final String jenisKelamin;
  late final int? usia;
  late final String mataPelajaran;
  late final String? pendidikan;
  late final String? universitas;
  late final int pengalaman;
  late final String? fotoUrl;
  late final String? iconUrl;
  late final String? deskripsi;

  Guru({
    required this.id,
    required this.slug,
    required this.nama,
    this.gelar,
    required this.jenisKelamin,
    this.usia,
    required this.mataPelajaran,
    this.pendidikan,
    this.universitas,
    required this.pengalaman,
    this.fotoUrl,
    this.iconUrl,
    this.deskripsi,
  });

  String get namaLengkap {
    if (gelar == null || gelar!.isEmpty) {
      return nama;
    }

    return '$nama, $gelar';
  }
}
