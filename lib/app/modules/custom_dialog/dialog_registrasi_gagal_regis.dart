import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/regist_rs/daftar_px.dart';

class DialogGagalRegis extends StatelessWidget {
  final DaftarPx daftarPx;
  const DialogGagalRegis({super.key, required this.daftarPx});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 20, left: 20, top: 200, bottom: 190),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/sudah_regis.png",
                  gaplessPlayback: true,
                  fit: BoxFit.fitHeight,
                  width: 200,
                  height: 200,
                ),
                Text(daftarPx.msg.toString(),
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 20),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.blue,
                          ),
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Kembali",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
