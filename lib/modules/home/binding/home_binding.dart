import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/modules/cart/controller/cart_controller.dart';
import 'package:shopping_cart/modules/home/controller/home_controller.dart';
import 'package:shopping_cart/modules/shopping/controller/shopping_controller.dart';

class HomeBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put<CartController>(CartController()),
      Bind.put<HomeController>(HomeController()),
      Bind.put<ShoppingController>(ShoppingController()),
    ];
  }
}
