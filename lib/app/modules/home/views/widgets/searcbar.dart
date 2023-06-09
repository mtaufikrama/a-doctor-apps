import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_listview_poli.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_page/search_page.dart';

import '../../../../data/componen/fetch_data.dart';
import '../../../../data/model/regist_rs/all_dokter_klinik.dart';
import '../../controllers/home_controller.dart';


class Searchbar extends GetView<HomeController> {
  const Searchbar ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: API.getAllDokterKlinik(filter: ''),
    builder: (context, snapshot) {
      if (snapshot.hasData &&
          snapshot.connectionState != ConnectionState.waiting &&
          snapshot.data != null) {
        final data = snapshot.data!.items!;
        return TextField(
            onTap: () =>
            showSearch(
              context: context,
              delegate: SearchPage<Items>(
                items: data,
                searchLabel:
                'Cari Nama Dokter/Spesialisasi/Hari Periksa',
                searchStyle:
                GoogleFonts.nunito(color: Colors.black),
                showItemsOnEmpty: true,
                failure: Center(
                  child: Text(
                    'Dokter Tidak Terdaftar :(',
                    style: GoogleFonts.nunito(),
                  ),
                ),
                filter: (dokter) =>
                [
                  dokter.id,
                  dokter.kodeDokter,
                  dokter.no.toString(),
                  dokter.namaPegawai,
                  dokter.namaBagian,
                  dokter.rangeHari,
                ],
                builder: (dokter) =>
                    CardListViewPoli(items: dokter),
              ),
            ),
            readOnly: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xfff6f6f6),
              suffixIcon:
              const Icon(Icons.search_rounded, color: Colors.grey),
              contentPadding:
              const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
              hintText: "Pencarian",
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
          );
      } else {
        return Container();
        }
      }
    );
  }
}
