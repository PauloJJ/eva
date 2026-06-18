import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxController {
  RxBool isInit = false.obs;

  Rx<InterstitialAd?> intersticialGeneral = Rx(null);
  Rx<BannerAd?> bannerQuiz = Rx(null);

  @override
  void onInit() {
    loadAndShowOpenAppAd();
    loadAndShowIntersticialGeneral(false);

    isInit.value = true;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();

    intersticialGeneral.value?.dispose();
    bannerQuiz.value?.dispose();
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
        },
      ),
    );
  }

  loadAndShowIntersticialGeneral(bool isShowNow) {
    String adUnitId = Platform.isAndroid
        ? 'ca-app-pub-4539366725503005/1351155393'
        : 'ca-app-pub-4539366725503005/2301233423';

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (isShowNow == true) {
            ad.show();
            return;
          }

          intersticialGeneral.value = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  loadBannerQuiz() async {
    String adUnitId = Platform.isAndroid
        ? 'ca-app-pub-4539366725503005/8866641778'
        : 'ca-app-pub-4539366725503005/8290797409';

    BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerQuiz.value = ad as BannerAd;
        },
      ),
      request: AdRequest(),
    ).load();
  }

  showIntersticialGeneral(bool isShowNow) async {
    if (isShowNow == true && intersticialGeneral.value != null) {
      await intersticialGeneral.value!.show();

      loadAndShowIntersticialGeneral(false);
      return;
    }

    loadAndShowIntersticialGeneral(isShowNow);
  }
}
