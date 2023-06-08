import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:text_scroll/text_scroll.dart';

import '../../../../data/model/regist_rs/all_dokter_klinik.dart';
import '../../../../routes/app_pages.dart';
import '../../../profile_view/profile_view.dart';

class CardListViewPoli extends StatelessWidget {
  final Items items;

  const CardListViewPoli({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    String formattedDays;
    List<String> days = items.rangeHari!.split(",");
    if (days.length <= 1) {
      formattedDays = days.first;
    } else {
      formattedDays =
          "${days.getRange(0, days.length - 1).join(', ')} dan ${days.last}";
    }
    String tag = items.toJson().toString();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.PAGE2, arguments: items),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFe0e0e0).withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(2, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: InkWell(
                  onTap: () => context.pushTransparentRoute(
                    ProfileViewView(
                      src: items.foto!,
                      tag: tag,
                    ),
                    transitionDuration: const Duration(
                      milliseconds: 700,
                    ),
                    reverseTransitionDuration: const Duration(
                      milliseconds: 700,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Hero(
                      tag: tag,
                      child: Image.network(
                        items.foto!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      items.namaPegawai!,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextScroll(
                        items.namaBagian!,
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                        intervalSpaces: 10,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(10, 0)),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xffecf8ff),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "$formattedDays\n${intl.DateFormat('HH:mm').format(DateTime.parse(items.jamMulai!))} - ${intl.DateFormat('HH:mm').format(DateTime.parse(items.jamAkhir!))}",
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
