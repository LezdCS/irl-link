import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';

class StoreController extends GetxController {
  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<ProductDetails> products = [];
  RxBool purchasePending = false.obs;
  RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;
  RxBool storeFound = false.obs;

  Set<String> kIds = <String>{'irl_premium_subscription'};

  @override
  Future<void> onInit() async {
    await getStore();
    await getStoreProducts();
    initListeningStorePurchase();
    super.onInit();
  }

  //Function isSubscribed
  bool isSubscribed() {
    return Platform.isIOS || kDebugMode || purchases.firstWhereOrNull(
          (element) => element.productID == kIds.first,
        ) !=
        null;
  }

  // Function get subscription price
  String getSubscriptionPrice() {
    return products
            .firstWhereOrNull(
              (element) => element.id == kIds.first,
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
      // Handle the error.
    }
    products = response.productDetails;
  }

  void initListeningStorePurchase() async {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
    }) as StreamSubscription<List<PurchaseDetails>>;

    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (error) {
      debugPrint('not logged to any store');
    }
  }

  void listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
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

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    purchases.add(purchaseDetails);
    purchasePending.value = false;
    Get.find<HomeViewController>().getSettings();

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
