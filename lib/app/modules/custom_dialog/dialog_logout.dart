import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/componen/data_regist_model.dart';
import '../../data/componen/local_storage.dart';
import '../../data/componen/publics.dart';
import '../../routes/app_pages.dart';

class DialogLogout extends StatelessWidget {
  const DialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 20, left: 20, top: 200, bottom: 200),
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
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/logout_apps.png",
                  gaplessPlayback: true,
                  fit: BoxFit.fitHeight,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Apakah anda ingin Logout ?",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 70, left: 10, top: 20),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.redAccent,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final getRegist = Publics.controller.getDataRegist;
                            await LocalStorages.boxDataRegist.erase();
                            await LocalStorages.boxToken.erase();
                            await LocalStorages.setDataRegist(
                              DataRegist(
                                email: getRegist.value.email,
                                password: getRegist.value.password,
                                ingatSaya: getRegist.value.ingatSaya,
                              ),
                            );
                            Publics.controller.getDataRegist.value =
                                LocalStorages.getDataRegist;
                            Publics.controller.getToken.value =
                                LocalStorages.getToken;
                            Get.offAllNamed(Routes.PAGE2);
                          },
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Logout",
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
