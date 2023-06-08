// import 'package:a_dokter_apps/app/modules/page2/controllers/page2_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../data/componen/fetch_data.dart';

// class DialogRegisPoli extends GetView<Page2Controller> {
//   const DialogRegisPoli({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           const EdgeInsets.only(right: 20, left: 20, top: 200, bottom: 200),
//       child: Card(
//         elevation: 7,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         color: Colors.white,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(right: 5, left: 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Image.asset(
//                   "assets/images/regis_poli2.png",
//                   gaplessPlayback: true,
//                   fit: BoxFit.fitHeight,
//                   width: 200,
//                   height: 200, // default is 15 FPS
//                 ),
//                 const Text(
//                     "Anda Belum Tedaftar Sebagai Pasien Lama Pada Rumah Sakit Pluit",
//                     style: TextStyle(
//                         color: Colors.black45,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 const Text(
//                     "Apakah anda ingin mendaftar sebagai \npasien baru pada Rumah Sakit Pluit",
//                     style: TextStyle(color: Colors.black45, fontSize: 15),
//                     textAlign: TextAlign.center),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => Get.back(),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.blue,
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.all(16),
//                             child: Text(
//                               "CANCEL",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 40,
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           final daftarPx = await API.postDaftarPx(
//                             namaPasien: controller.namaController.text,
//                             jadwal:
//                                 controller.listAntrianDokter.value.jam ?? '',
//                             noAntrian:
//                                 (controller.listAntrianDokter.value.antrian ??
//                                         0)
//                                     .toString(),
//                             noKtp: controller.dataRegist.value.noKtp ?? '',
//                             kodeDokter: controller.items.kodeDokter ?? '',
//                             kodeBagian: controller.items.kodeBagian ?? '',
//                             namaBagian: controller.items.namaBagian ?? '',
//                             namaKlinik: 'Rumah Sakit Pluit',
//                             namaDokter: controller.items.namaPegawai ?? '',
//                             durasi:
//                                 controller.listAntrianDokter.value.durasi ?? '',
//                             ketKlinik: 'Baru',
//                             tglDaftar: controller.jadwalController.text,
//                           );
//                           Get.back();
//                           if (daftarPx.code.toString() == '500') {
//                             Get.dialog(DialogGagalRegis(
//                                 daftarPx:
//                                     DaftarPx.fromJson(daftarPx.toJson())));
//                           } else if (daftarPx.code.toString() == '200') {
//                             Get.dialog(const DialogSuksesRegis());
//                           }
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.greenAccent,
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.all(16),
//                             child: Text(
//                               "REGIST",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
