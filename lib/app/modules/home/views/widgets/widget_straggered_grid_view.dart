import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/componen/my_colors.dart';
import '../../../../data/componen/my_font_size.dart';
import '../../../../routes/app_pages.dart';
import 'custom_card.dart';

class WidgetStraggeredGridView extends StatelessWidget {
  const WidgetStraggeredGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          CustomCard(
            onTap: () {
              // Get.toNamed(Routes.REGISTER_RS);
            },
            shadow: false,
            shadowBlur: 0,
            width: double.infinity,
            bgColor: MyColors.white,
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                  shadow: false,
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: SvgPicture.asset("assets/images/regis.svg"),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Dokter \nUmum",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: MyColors.blackText,
                    fontSize: MyFontSize.small3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          CustomCard(
            onTap: () {
              // Get.toNamed(Routes.REGISTER_TELEMEDIC);
            },
            shadow: false,
            shadowBlur: 0,
            width: double.infinity,
            bgColor: MyColors.white,
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                    shadow: false,
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(100),
                    child: Center(
                      child: SvgPicture.asset("assets/images/tele.svg"),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Riwayat \nAntrian",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: MyColors.blackText,
                    fontSize: MyFontSize.small3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          CustomCard(
            onTap: () {
              // Get.toNamed(Routes.DAFTAR_ANTRIAN);
            },
            shadow: false,
            shadowBlur: 0,
            width: double.infinity,
            bgColor: MyColors.white,
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                    shadow: false,
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(100),
                    child: Center(
                      child: SvgPicture.asset("assets/images/antri.svg"),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Daftar \nAntrian",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: MyColors.blackText,
                    fontSize: MyFontSize.small3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          CustomCard(
            onTap: () {
              // Get.toNamed(Routes.RIWAYAT_MEDIS);
            },
            shadow: false,
            shadowBlur: 0,
            width: double.infinity,
            bgColor: MyColors.white,
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                    shadow: false,
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(100),
                    child: Center(
                      child: SvgPicture.asset("assets/images/riwayat.svg"),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Riwayat \nMedis",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: MyColors.blackText,
                    fontSize: MyFontSize.small3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
