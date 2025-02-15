import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/modules/cart/controller/cart_controller.dart';
import 'package:shopping_cart/modules/home/controller/home_controller.dart';
import 'package:shopping_cart/modules/shopping/controller/shopping_controller.dart';

class HomeBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<HomeController>(() => HomeController()),
      Bind.lazyPut<ShoppingController>(() => ShoppingController()),
      Bind.lazyPut<CartController>(() => CartController()),
    ];
  }
}
