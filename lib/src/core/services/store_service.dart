import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:irllink/src/core/utils/init_dio.dart';
import 'package:irllink/src/domain/entities/twitch/twitch_credentials.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';
import 'package:irllink/src/presentation/controllers/tabs_controller.dart';
import 'package:store_checker/store_checker.dart';
import 'package:talker_flutter/talker_flutter.dart';

class StoreService extends GetxService {
  StoreService({
    required this.getTwitchLocalUseCase,
    required this.talker,
  });

  final GetTwitchLocalUseCase getTwitchLocalUseCase;
  final Talker talker;

  Dio dioClient = initDio('');

  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<ProductDetails> products = [];
  RxBool purchasePending = false.obs;
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;
  RxBool storeFound = false.obs;

  Set<String> kIds = <String>{'irl_premium_subscription', 'irl_premium'};

  Future<StoreService> init() async {
    await getStore();
    if (!storeFound.value) {
      return this;
    }
    await getStoreProducts();
    initListeningStorePurchase();
    return this;
  }

  //Function isSubscribed
  bool isSubscribed() {
    return true;
  }

  // Function get subscription price
  String getSubscriptionPrice() {
    return products
            .firstWhereOrNull(
              (p) => kIds.contains(p.id),
            )
            ?.price ??
        "";
  }

  Future<void> getStore() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (available) {
      storeFound.value = true;
    }
  }

  Future<void> getStoreProducts() async {
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      talker
        ..debug('Products not found: ${response.notFoundIDs}')
        ..debug('Products found: ${response.productDetails.map((e) => e.id)}');
    }
    products = response.productDetails;
  }

  void initListeningStorePurchase() async {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        subscription.cancel();
      },
      onError: (error) {
        // handle error here.
      },
    ) as StreamSubscription<List<PurchaseDetails>>;

    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (error) {
      talker.error('Not logged to any store.');
    }
  }

  void listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        purchasePending.value = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          purchasePending.value = false;
          Get.snackbar(
            "Error",
            purchaseDetails.error!.message,
            snackPosition: SnackPosition.TOP,
            icon: const Icon(Icons.error_outline, color: Colors.red),
            borderWidth: 1,
            borderColor: Colors.red,
          );
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            Get.snackbar(
              "Error",
              "Invalid purchase",
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.error_outline, color: Colors.red),
              borderWidth: 1,
              borderColor: Colors.red,
            );
            purchasePending.value = false;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) async {
    TwitchCredentials? twitchCredentials;
    final getLocalResult = await getTwitchLocalUseCase();
    getLocalResult.fold(
      (l) => {},
      (r) => twitchCredentials = r,
    );

    String? purchaseToken =
        purchaseDetails.verificationData.serverVerificationData;
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();

    String url = remoteConfig.getString('verify_android_purchase');
    if (kDebugMode) {
      url = remoteConfig.getString('verify_android_purchase_dev');
    }
    if (Platform.isIOS) {
      url = remoteConfig.getString('verify_ios_purchase');
      if (kDebugMode) {
        url = remoteConfig.getString('verify_ios_purchase_dev');
      }
    }

    Source source = await StoreChecker.getSource;
    String environment = kDebugMode ? 'Sandbox' : 'Production';
    if (source == Source.IS_INSTALLED_FROM_TEST_FLIGHT) {
      environment = 'Sandbox';
    }

    try {
      await dioClient.post(
        url,
        data: {
          'purchaseToken': purchaseToken,
          'twitchId': twitchCredentials?.twitchUser.id,
          'environment': environment,
        },
      );
      return Future<bool>.value(true);
    } on DioException catch (e) {
      talker.error(e.toString());
      return Future<bool>.value(false);
    }
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    if (purchases.firstWhereOrNull(
          (p) => p.productID == purchaseDetails.productID,
        ) !=
        null) {
      return;
    }
    purchases.add(purchaseDetails);
    purchasePending.value = false;

    // Generate the tabs
    Get.find<TabsController>().generateTabs();

    if (purchaseDetails.status == PurchaseStatus.purchased) {
      Get.back();
      Get.snackbar(
        "Success",
        "Thanks for your purchase, enjoy your premium subscription!",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.check, color: Colors.green),
        borderWidth: 1,
        borderColor: Colors.green,
      );
    }
  }

  void purchase() async {
    final ProductDetails productDetails = products[0];
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }
}
