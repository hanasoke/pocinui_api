class Program {
  late final int id;
  late final String slug;
  late final String namaProgram;
  late final String mataPelajaran;
  late final String jenjang;
  late final String? deskripsi;
  late final String? jadwal;
  late final dynamic harga;
  late final String? gambarUrl;
  late final String? iconUrl;
  late final bool aktif;

  Program({
    required this.id,
    required this.slug,
    required this.namaProgram,
    required this.mataPelajaran,
    required this.jenjang,
    this.deskripsi,
    this.jadwal,
    this.harga,
    this.gambarUrl,
    this.iconUrl,
    required this.aktif,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      slug: json['slug'],
      namaProgram: json['nama_program'] ?? '',
      mataPelajaran: json['mata_pelajaran'] ?? '',
      jenjang: json['jenjang'],
      deskripsi: json['deskripsi'],
      jadwal: json['jadwal'],
      harga: json['harga'],
      gambarUrl: json['gambar_url'],
      iconUrl: json['icon_url'],
      aktif: json['aktif'] ?? true,
    );
  }
}
