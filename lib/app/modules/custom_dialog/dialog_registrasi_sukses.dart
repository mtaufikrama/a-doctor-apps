// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pluitcare/app/routes/app_pages.dart';

// class DialogSuksesRegis extends StatelessWidget {
//   const DialogSuksesRegis({super.key});

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
//                   "assets/images/regis_poli.png",
//                   gaplessPlayback: true,
//                   fit: BoxFit.fitHeight,
//                   width: 200,
//                   height: 200,
//                 ),
//                 const Text(
//                     "Sukses Melakukan Perjanjian Dokter, Silahkan datang ke RS untuk Melakukan Verifikasi Bail Lewat FO atau QRCode",
//                     style: TextStyle(
//                         color: Colors.black45,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(right: 10, left: 10, top: 20),
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.back();
//                           Get.toNamed(Routes.DAFTAR_ANTRIAN);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.blue,
//                           ),
//                           child: Column(
//                             children: const [
//                               Padding(
//                                 padding: EdgeInsets.all(16),
//                                 child: Text(
//                                   "Lihat Antrian",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
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
