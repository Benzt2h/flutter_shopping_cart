import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/service/order_service.dart';

class CartController extends GetxController {
  final OrderService orderService = OrderService();

  RxList<ProductInfo> cartItems = <ProductInfo>[].obs;
  final isCheckOrderSuccess = false.obs;
  final errorMessage = ''.obs;
  final sumPrice = 0.0.obs;
  final discountPrice = 0.0.obs;

  void setIsCheckOrderSuccess(bool status) {
    isCheckOrderSuccess(status);
  }

  @override
  void onInit() {
    super.onInit();
    ever(
      cartItems,
      (_) {
        calSumPrice();
        caldiscountPrice();
      },
    );
  }

  void calSumPrice() {
    sumPrice(
        cartItems.fold(0, (sum, item) => sum! + item.price * item.quantity));
  }

  void caldiscountPrice() {
    double discount = 0;
    for (ProductInfo productInfo in cartItems) {
      if (productInfo.quantity < 2) continue;
      int multDiscount = productInfo.quantity ~/ 2;
      double discountOne = (productInfo.price * 2) * 0.05;

      discount += discountOne * multDiscount;
    }
    discountPrice(discount);
  }

  void addToCart(ProductInfo productInfo) {
    cartItems.add(
      ProductInfo(
        id: productInfo.id,
        modifilerId: productInfo.modifilerId,
        name: productInfo.name,
        price: productInfo.price,
        quantity: 1,
      ),
    );
  }

  void increaseItem(ProductInfo productInfo) {
    int index = cartItems
        .indexWhere((item) => item.modifilerId == productInfo.modifilerId);
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseItem(ProductInfo productInfo) {
    int index = cartItems
        .indexWhere((item) => item.modifilerId == productInfo.modifilerId);
    if (cartItems[index].quantity == 1) return;
    cartItems[index].quantity--;
    cartItems.refresh();
  }

  void deleteItem(ProductInfo productInfo) {
    cartItems
        .removeWhere((item) => item.modifilerId == productInfo.modifilerId);
    cartItems.refresh();
  }

  Future postCheckout() async {
    try {
      await orderService.postCheckout(cartItems.map((e) => e.id).toList());
      errorMessage("");
      setIsCheckOrderSuccess(true);
      cartItems.clear();
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }
}
