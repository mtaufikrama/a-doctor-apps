// main.dart
import 'package:a_dokter_apps/app/modules/home/controllers/home_controller.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/card_noantri.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/searcbar.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_dropdownListExample.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_listview_poli.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_straggered_grid_view.dart';
import 'package:a_dokter_apps/app/modules/home/views/widgets/widget_title_poli.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_work_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_rounded),
            label: 'Medical Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people),
            label: 'Profile',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: const FlexibleSpaceBar(
                ),
            automaticallyImplyLeading: true,
            floating: true,
            pinned: true,
            snap: true,
            stretch: true,
            title: Image.asset('assets/images/icons/logo.png',
            width: 130,
            height: 130,),
            actions: [
            ],
            bottom: AppBar(
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Searchbar(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate(
              [
                WidgetStraggeredGridView(),
                Container(
                  height: 20000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(0.0),
                      topLeft: Radius.circular(0.0),
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
                    WidgetTitlePoli(),
                    const SizedBox(
                      height: 10,
                    ),
                    DropDownListExample(),
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
