class GetAllDokterKlinik {
  String? count;
  String? msg;
  int? code;
  List<Items>? items;

  GetAllDokterKlinik({this.count, this.code, this.items});

  GetAllDokterKlinik.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    msg = json['msg'];
    code = json['code'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['msg'] = msg;
    data['code'] = code;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? kodeDokter;
  String? id;
  String? namaPegawai;
  String? jamMulai;
  String? jamAkhir;
  String? namaBagian;
  String? rangeHari;
  String? noInduk;
  String? waktuPeriksa;
  String? kodeBagian;
  String? foto;
  int? no;

  Items(
      {this.kodeDokter,
      this.id,
      this.namaPegawai,
      this.jamMulai,
      this.jamAkhir,
      this.namaBagian,
      this.rangeHari,
      this.noInduk,
      this.waktuPeriksa,
      this.kodeBagian,
      this.foto,
      this.no});

  Items.fromJson(Map<String, dynamic> json) {
    kodeDokter = json['kode_dokter'];
    id = json['id'];
    namaPegawai = json['nama_pegawai'];
    jamMulai = json['jam_mulai'];
    jamAkhir = json['jam_akhir'];
    namaBagian = json['nama_bagian'];
    rangeHari = json['range_hari'];
    noInduk = json['no_induk'];
    waktuPeriksa = json['waktu_periksa'];
    kodeBagian = json['kode_bagian'];
    foto = json['foto'];
    no = json['no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kode_dokter'] = kodeDokter;
    data['id'] = id;
    data['nama_pegawai'] = namaPegawai;
    data['jam_mulai'] = jamMulai;
    data['jam_akhir'] = jamAkhir;
    data['nama_bagian'] = namaBagian;
    data['range_hari'] = rangeHari;
    data['no_induk'] = noInduk;
    data['waktu_periksa'] = waktuPeriksa;
    data['kode_bagian'] = kodeBagian;
    data['foto'] = foto;
    data['no'] = no;
    return data;
  }
}
