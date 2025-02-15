import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/service/product_service.dart';

class ShoppingController extends GetxController {
  final ProductService productService = ProductService();

  final isLoadingRecommended = true.obs;
  final errorMessageRecommended = "".obs;
  RxList<ProductInfo> recommendedProducts = <ProductInfo>[].obs;

  @override
  void onInit() {
    getRecommendedProducts();
    super.onInit();
  }

  Future getRecommendedProducts() async {
    try {
      isLoadingRecommended.value = true;
      recommendedProducts.value = await productService.getRecommendedProducts();
      errorMessageRecommended("");
      isLoadingRecommended.value = false;
    } catch (e) {
      errorMessageRecommended(e.toString());
      Get.snackbar("Error", e.toString());
      isLoadingRecommended.value = false;
    }
  }
}
