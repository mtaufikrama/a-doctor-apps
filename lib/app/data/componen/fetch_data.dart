import 'dart:convert';
import 'package:a_dokter_apps/app/data/componen/publics.dart';
import 'package:a_dokter_apps/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import '../model/antrian_rs/jadwal_px.dart';
import '../model/antrian_rs/jadwal_px_detail.dart';
import '../model/homepage/detail_klinik.dart';
import '../model/homepage/poli.dart';
import '../model/login_and_regist/akses_px.dart';
import '../model/login_and_regist/daftar_px_baru.dart';
import '../model/login_and_regist/token.dart';
import '../model/mr_pasien/detailRiwayat.dart';
import '../model/mr_pasien/listMRPX.dart';
import '../model/profile_pasien/data_pasien.dart';
import '../model/profile_pasien/data_px.dart';
import '../model/regist_hemo/asuransi.dart';
import '../model/regist_hemo/dokter_hemo.dart';
import '../model/regist_rs/all_dokter_klinik.dart';
import '../model/regist_rs/antrian_dokter.dart';
import '../model/regist_rs/dokter_by_name.dart';
import 'data_regist_model.dart';
import 'local_storage.dart';

class API {
  static const _url = 'https://rspluit-dev.sirs.co.id/';
  static const _baseUrl = '${_url}api/v1';
  static const _kodeKlinik = 'C00002';
  static const _getToken = '$_baseUrl/get-token.php';
  static const _getAksesPx = '$_baseUrl/px-akses.php';
  static const _postDaftarPxBaru = '$_baseUrl/post-daftar-px-baru.php';
  static const _getPoli = '$_baseUrl/get-poli.php';
  static const _getAllDokterKlinik = '$_baseUrl/get-all-dokter-klinik-new.php';
  static const _getDokterKlinik = '$_baseUrl/get-dokter-klinik.php';
  static const _getAntrianDokter = '$_baseUrl/get-antrian-dokter.php';
  static const _postDaftarPx = '$_baseUrl/post-daftar-px.php';
  static const _getAsuransiPx = '$_baseUrl/get-asuransi-px.php';
  static const _getDokterHemo = '$_baseUrl/get-dokter-hemo.php';
  static const _postDaftarHemo = '$_baseUrl/post-daftar-hemo.php';
  static const _getJadwalPx = '$_baseUrl/get-jadwal-px.php';
  static const _getJadwalHemoPx = '$_baseUrl/get-jadwal-hemo-px.php';
  static const _getJadwalPxDetail = '$_baseUrl/get-jadwal-px-detail.php';
  static const _getJadwalHemoDetail = '$_baseUrl/get-jadwal-hemo-detail.php';
  static const _scanAntrianKlinik = '$_baseUrl/scan_antrian_klinik.php';
  static const _getDataPasien = '$_baseUrl/get-data-pasien.php';
  static const _getDataPx = '$_baseUrl/get-data-px.php';
  static const _editPasienLama = '$_baseUrl/edit_pasien_lama.php';
  static const _editFotoPasien = '$_baseUrl/edit_foto_pasien.php';
  static const _editFotoKtp = '$_baseUrl/edit_foto_ktp.php';
  static const _getListMr = '$_baseUrl/get-list-mr.php';
  static const _getDetailHistory = '$_baseUrl/get-detail-riwayat.php';
  static const _getFotoRad = '$_baseUrl/get-foto-rad.php';
  static const _getCetakResep = '$_baseUrl/get-cetak-resep.php';
  static const _getKlinikDetail = '$_baseUrl/get-klinik-detail.php';

  static Future<Token> getToken() async {
    var response = await Dio().post(_getToken, data: {
      "KodeApi": "MUSA",
      "KeyApi": "@@TTWYYW",
      "KeyCode":
          "602f07f23fc390cfd4461b268f95eddfbd4fc87d9b313b64a943801b5e4c5b12"
    });
    final data = jsonDecode(response.data);
    final obj = Token.fromJson(data);
    await LocalStorages.setToken(obj);
    return obj;
  }

  static Future<AksesPX> getAksesPx(
      {required String user, required String pass}) async {
    var token = await getToken();
    String generateMd5(String input) {
      return md5.convert(utf8.encode(input)).toString();
    }

    final data = {"User": user, "Pass": generateMd5(pass)};
    var response = await Dio().post(
      _getAksesPx,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final datas = jsonDecode(response.data);
    final obj = AksesPX.fromJson(datas);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    } else {
      if (obj.code != 200) {
        Get.back();
        Get.snackbar(
          obj.code.toString(),
          obj.msg.toString(),
        );
      } else {
        DataPasien dataPasien = await API.getDataPasien(noKtp: obj.res!.noKtp!);
        await LocalStorages.setDataRegist(DataRegist(
          email: user,
          password: pass,
          fotoPasien: obj.res!.fotoPasien,
          noKtp: obj.res!.noKtp,
          namaPasien: obj.res!.namaPasien,
          alamat: dataPasien.res!.first.alamat,
          alergi: dataPasien.res!.first.alergi,
          golonganDarah: dataPasien.res!.first.golDarah,
          jenisKelamin: dataPasien.res!.first.gender,
          noHp: dataPasien.res!.first.noHp,
          tanggalLahir: dataPasien.res!.first.tglLhr,
          umur: dataPasien.res!.first.umur,
        ));
      }
    }
    return obj;
  }

  static Future<dynamic> postDaftarPxBaru(
      {required String namaPasien,
      required String email,
      required String noKtp,
      required String jenisKelamin,
      required String tanggalLahir,
      required String noHp,
      required String alamat,
      required String alergi,
      required String golonganDarah,
      required String password}) async {
    var token = await getToken();
    final data = {
      "nama_pasien": namaPasien,
      "email": email,
      "no_ktp": noKtp,
      "jenis_kelamin": jenisKelamin,
      "tanggal_lahir": tanggalLahir,
      "no_hp": noHp,
      "alamat": alamat,
      "alergi": alergi,
      "golongan_darah": golonganDarah,
      "password": password
    };
    var response = await Dio().post(
      _postDaftarPxBaru,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = jsonDecode(response.data);
    if (obj['msg'] == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj['code'].toString(),
        obj['msg'].toString(),
      );
    } else {
      if (obj['code'] != 200) {
        Get.snackbar(
          obj['code'].toString(),
          obj['msg'].toString(),
        );
      } else {
        await LocalStorages.setDataRegist(DataRegist(
          alamat: alamat,
          alergi: alergi,
          email: email,
          golonganDarah: golonganDarah,
          jenisKelamin: jenisKelamin,
          namaPasien: namaPasien,
          noHp: noHp,
          noKtp: noKtp,
          password: password,
          tanggalLahir: tanggalLahir,
        ));
      }
    }
    return obj;
  }

  static Future<Poli> getPoli() async {
    var token = await getToken();
    var data = {"kode_klinik": _kodeKlinik};
    var response = await Dio().post(
      _getPoli,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = Poli.fromJson(jsonDecode(response.data));
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<GetAllDokterKlinik> getAllDokterKlinik(
      {required String filter}) async {
    var data = {"filter": filter};
    final token = await getToken();
    var response = await Dio().post(
      _getAllDokterKlinik,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data!);
    final obj = GetAllDokterKlinik.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<GetDokterByName> getDokterByName(
      {required String namaDokter}) async {
    var token = Publics.controller.getToken.value;
    var data = {"kode_klinik": _kodeKlinik, "filter": namaDokter};
    var response = await Dio().post(
      _getDokterKlinik,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = GetDokterByName.fromJson(jsonDecode(response.data));
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> postDaftarPx(
      {required String namaPasien,
      required String jadwal,
      required String noAntrian,
      required String noKtp,
      required String kodeDokter,
      required String kodeBagian,
      required String namaBagian,
      required String namaKlinik,
      required String namaDokter,
      required String durasi,
      required String ketKlinik,
      required String tglDaftar}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "nama_pasien": namaPasien,
      "jadwal": jadwal,
      "no_antrian": noAntrian,
      "no_ktp": noKtp,
      "kode_dokter": kodeDokter,
      "kode_bagian": kodeBagian,
      "nama_bagian": namaBagian,
      "nama_klinik": namaKlinik,
      "nama_dokter": namaDokter,
      "durasi": durasi,
      "ket_klinik": ketKlinik,
      "kode_klinik": _kodeKlinik,
      "tgl_daftar": tglDaftar
    };
    var response = await Dio().post(
      _postDaftarPx,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data!);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<AsuransiPx> getAsuransiPx() async {
    var token = Publics.controller.getToken.value;
    var data = {};
    var response = await Dio().post(
      _getAsuransiPx,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final value = jsonDecode(response.data);
    final obj = AsuransiPx.fromJson(value);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DokterHemo> getDokterHemo() async {
    var token = Publics.controller.getToken.value;
    var data = {};
    var response = await Dio().post(
      _getDokterHemo,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DokterHemo.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<AntrianDokter> getAntrianDokter(
      {required String id,
      required String kodeDokter,
      required String tglDaftar}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "kode_klinik": _kodeKlinik,
      "src": {"id": id, "kode_dokter": kodeDokter, "tgl_daftar": tglDaftar}
    };
    var response = await Dio().post(
      _getAntrianDokter,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = AntrianDokter.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> postDaftarHemo(
      {required String namaPasien,
      required String noKtp,
      required String flagPesan,
      required String kodeDokter,
      required String namaDokter,
      required String tglDaftar}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "nama_pasien": namaPasien,
      "no_ktp": noKtp,
      "flag_pesan": flagPesan,
      "kode_rs": _kodeKlinik,
      "kode_dokter": kodeDokter,
      "nama_dokter": namaDokter,
      "tgl_daftar": tglDaftar
    };
    var response = await Dio().post(
      _postDaftarHemo,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<JadwalPx> getJadwalPx(
      {required String noKtp, required String tgl}) async {
    var token = Publics.controller.getToken.value;
    var data = {"no_ktp": noKtp, "tgl": tgl};
    var response = await Dio().post(
      _getJadwalPx,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = JadwalPx.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> getJadwalHemoPx(
      {required String noKtp, required String tgl}) async {
    var token = Publics.controller.getToken.value;
    var data = {"no_ktp": noKtp, "tgl": tgl};
    var response = await Dio().post(
      _getJadwalHemoPx,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<JadwalPxDetail> getJadwalPxDetail(
      {required String idReq}) async {
    var token = Publics.controller.getToken.value;
    var data = {"kode_klinik": _kodeKlinik, "idReg": idReq};
    var response = await Dio().post(
      _getJadwalPxDetail,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = JadwalPxDetail.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> getJadwalHemoDetail(
      {required String idReq}) async {
    var token = Publics.controller.getToken.value;
    var data = {"idReg": idReq};
    var response = await Dio().post(
      _getJadwalHemoDetail,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> scanAntrianKlinik(
      {required String noKtp,
      required String idReqKlinik,
      required String kodeKlinik}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "kode_klinik": kodeKlinik,
      "no_ktp": noKtp,
      "idRegKlinik": idReqKlinik
    };
    var response = await Dio().post(
      _scanAntrianKlinik,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DataPasien> getDataPasien({required String noKtp}) async {
    var token = Publics.controller.getToken.value;
    var data = {"no_ktp": noKtp};
    var response = await Dio().post(
      _getDataPasien,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = DataPasien.fromJson(jsonDecode(response.data));
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DataPx> getDataPx({required String noKtp}) async {
    var token = Publics.controller.getToken.value;
    var data = {"no_ktp": noKtp};
    var response = await Dio().post(
      _getDataPx,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DataPx.fromJson(json);
    return obj;
  }

  static Future<dynamic> editPasienLama(
      {required String noKtp,
      required String namaPasien,
      required String umurPasien,
      required String golDarah,
      required String tanggalLahir,
      required String tempatLahir,
      required String gender,
      required String alergi,
      required String alamat}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "no_ktp": noKtp,
      "namaPasien": namaPasien,
      "umurPasien": umurPasien,
      "gol_darah": golDarah,
      "tanggal_lhr": tanggalLahir,
      "tempat_lhr": tempatLahir,
      "gender": gender,
      "alergi": alergi,
      "alamat": alamat
    };
    var response = await Dio().post(
      _editPasienLama,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = jsonDecode(response.data);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> editFotoPasien(
      {required String noKtp, required String fotoProfile}) async {
    var token = Publics.controller.getToken.value;
    var data = {"no_ktp": noKtp, "fotoProfile": fotoProfile};
    var response = await Dio().post(
      _editFotoPasien,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> editFotoKtp(
      {required String noKtp, required String fotoKtp}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "no_ktp": noKtp,
      "fotoktp": fotoKtp //((Base64 String Foto))
    };
    var response = await Dio().post(
      _editFotoKtp,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<ListMRPX> getListMr(
      {required String noKtp, required String tgl}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "kode_klinik": _kodeKlinik,
      "ktp": noKtp,
      "url_rs": _url,
      "tgl_mr": tgl,
    };
    var response = await Dio().post(
      _getListMr,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = ListMRPX.fromJson(jsonDecode(response.data));
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    } else {
      if (obj.code != 200) {
        Get.snackbar(
          obj.code.toString(),
          obj.msg.toString(),
        );
      }
    }
    return obj;
  }

  static Future<DetailRiwayat> getDetailRiwayat({required String id}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "kode_klinik": _kodeKlinik,
      "id": id,
      "url_rs": _url,
    };
    var response = await Dio().post(
      _getDetailHistory,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final obj = DetailRiwayat.fromJson(jsonDecode(response.data));
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    } else {
      if (obj.code != 200) {
        Get.offAllNamed(Routes.PAGE2);
        Get.snackbar(
          obj.code.toString(),
          obj.msg.toString(),
        );
      }
    }
    return obj;
  }

  static Future<DaftarPXBaru> getFotoRad(
      {required String kdPenunjang, required String kodeTarif}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "kode_klinik": _kodeKlinik,
      "param": {"kd_penunjang": kdPenunjang, "kode_tarif": kodeTarif}
    };
    var response = await Dio().post(
      _getFotoRad,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DaftarPXBaru> getCetakResep(
      {required String noMr,
      required String noRegister,
      required String noKunjungan,
      required String kodePesanResepDr}) async {
    var token = Publics.controller.getToken.value;
    var data = {
      "kode_klinik": _kodeKlinik,
      "no_mr": noMr,
      "no_registrasi": noRegister,
      "no_kunjungan": noKunjungan,
      "kode_pesan_resep_dr": kodePesanResepDr
    };
    var response = await Dio().post(
      _getCetakResep,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
      data: data,
    );
    final json = jsonDecode(response.data);
    final obj = DaftarPXBaru.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    }
    return obj;
  }

  static Future<DetailKlinik> getDetailKlinik() async {
    var token = Publics.controller.getToken.value;
    var response = await Dio().post(
      _getKlinikDetail,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "X-Api-Token": token.token,
        },
      ),
    );
    final json = jsonDecode(response.data);
    final obj = DetailKlinik.fromJson(json);
    if (obj.msg == 'Invalid token: Expired') {
      Get.offAllNamed(Routes.PAGE2);
      Get.snackbar(
        obj.code.toString(),
        obj.msg.toString(),
      );
    } else {
      if (obj.code != 200) {
        Get.offAllNamed(Routes.PAGE2);
        Get.snackbar(
          obj.code.toString(),
          obj.msg.toString(),
        );
      }
    }
    return obj;
  }
}
