import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/service/product_service.dart';

class ShoppingController extends GetxController {
  final ProductService productService = ProductService();

  final isLoadingRecommended = true.obs;
  final errorMessageRecommended = "".obs;
  RxList<ProductInfo> recommendedProducts = <ProductInfo>[].obs;

  ScrollController scrollController = ScrollController();
  final isLoadingLatest = true.obs;
  final isLoadingMoreLatest = false.obs;
  final errorMessageLatest = "".obs;
  RxList<ProductInfo> latestProducts = <ProductInfo>[].obs;
  String nextCursor = "";

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    getRecommendedProducts();
    getLatestProducts();
    super.onInit();
  }

  Future getRecommendedProducts() async {
    try {
      isLoadingRecommended.value = true;
      errorMessageRecommended("");
      recommendedProducts.value = await productService.getRecommendedProducts();

      isLoadingRecommended.value = false;
    } catch (e) {
      errorMessageRecommended(e.toString());
      Get.snackbar("Error", e.toString());
      isLoadingRecommended.value = false;
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getLatestProducts();
    }
  }

  Future getLatestProducts() async {
    try {
      if (latestProducts.isEmpty) {
        isLoadingLatest.value = true;
        errorMessageLatest("");
      } else {
        isLoadingMoreLatest.value = true;
      }
      Map<String, dynamic> res =
          await productService.getLatestProducts(nextCursor);
      latestProducts.addAll(res['items']);
      nextCursor = res['nextCursor'];

      isLoadingLatest.value = false;
      isLoadingMoreLatest.value = false;
    } catch (e) {
      if (latestProducts.isEmpty) {
        errorMessageLatest(e.toString());
      }
      isLoadingLatest.value = false;
      Future.delayed(Duration(milliseconds: 500), () {
        Get.snackbar("Error", e.toString());
        isLoadingMoreLatest.value = false;
      });
    }
  }
}
