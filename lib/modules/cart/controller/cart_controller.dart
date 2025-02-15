import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';

class CartController extends GetxController {
  RxList<ProductInfo> cartItems = <ProductInfo>[].obs;

  void addToCart(ProductInfo productInfo) {
    cartItems.add(
      ProductInfo(
        id: productInfo.id,
        name: productInfo.name,
        price: productInfo.price,
        quantity: 1,
      ),
    );
  }

  void increaseItem(ProductInfo productInfo) {
    int index = cartItems.indexWhere((item) => item.id == productInfo.id);
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseItem(ProductInfo productInfo) {
    int index = cartItems.indexWhere((item) => item.id == productInfo.id);
    if (cartItems[index].quantity == 1) return;
    cartItems[index].quantity--;
    cartItems.refresh();
  }

  void deleteItem(ProductInfo productInfo) {
    cartItems.removeWhere((item) => item.id == productInfo.id);
    cartItems.refresh();
  }
}
