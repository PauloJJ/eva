import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxController {
  RxBool isInit = false.obs;

  @override
  void onInit() {
    loadAndShowOpenAppAd();

    isInit.value = true;
    super.onInit();
  }

  loadAndShowOpenAppAd() {
    String adUnitId = Platform.isAndroid
        ? 'ca-app-pub-4539366725503005/5273841463'
        : 'ca-app-pub-4539366725503005/7522696243';

    if (isInit.value == true) {
      return;
    }

    AppOpenAd.load(
      adUnitId: adUnitId,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (error) {
          print(
            '======================= ERRO SHOW ANUNCIO =======================',
          );
          print(error.message);
        },
      ),
    );
  }
}
