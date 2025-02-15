import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/modules/cart/controller/cart_controller.dart';

class HomeController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  void routeToCart() async {
    await Get.toNamed('/cart');
    cartController.setIsCheckOrderSuccess(false);
  }
}
