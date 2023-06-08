// main.dart
import 'package:a_dokter_apps/app/modules/home/controllers/home_controller.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/card_noantri.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_dropdownListExample.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_listview_poli.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_title_poli2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_page/search_page.dart';
import '../../../data/componen/fetch_data.dart';
import '../../../data/componen/my_font_size.dart';
import '../../../data/model/regist_rs/all_dokter_klinik.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4babe7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: const FlexibleSpaceBar(
                // background: Image.asset(
                //   'assets/images/frame1.png',
                //   fit: BoxFit.cover,
                // ),
                ),
            automaticallyImplyLeading: true,
            floating: true,
            pinned: true,
            snap: true,
            stretch: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_circle_left_rounded),
                color: Colors.blue,
                iconSize: 40,
                onPressed: () {
                  Get.back();
                }),
            title: Text(
              "Pilih Poli",
              style: GoogleFonts.nunito(
                  fontSize: MyFontSize.large1, fontWeight: FontWeight.bold),
            ),
            actions: [
              FutureBuilder(
                  future: API.getAllDokterKlinik(filter: ''),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState != ConnectionState.waiting &&
                        snapshot.data != null) {
                      final data = snapshot.data!.items!;
                      return IconButton(
                        onPressed: () => showSearch(
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
                            filter: (dokter) => [
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
                        icon: const Icon(
                          Icons.person_search_rounded,
                          size: 30,
                        ),
                        color: Colors.blue,
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
            bottom: AppBar(
              backgroundColor: const Color(0xff4babe7),
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  DropDownListExample(),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const WidgetTitlePoli2(),
                Container(
                  height: 20000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFe0e0e0).withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(2, 1),
                      ),
                    ],
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return FutureBuilder(
                        future: API.getAllDokterKlinik(
                            filter: controller.namaBagian.value),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState !=
                                  ConnectionState.waiting &&
                              snapshot.data != null) {
                            GetAllDokterKlinik getAllDokterKlinik =
                                snapshot.data ?? GetAllDokterKlinik();
                            return Column(
                              children: getAllDokterKlinik.items != null
                                  ? getAllDokterKlinik.items!.map((e) {
                                      return CardListViewPoli(items: e);
                                    }).toList()
                                  : [const CardNoAntrian()],
                            );
                          } else {
                            return SizedBox(
                              height: Get.height - 250,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                        },
                      );
                    }),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
