import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/modules/cart/controller/cart_controller.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    super.key,
    required this.productInfo,
    this.isCart = false,
  });

  final bool isCart;
  final ProductInfo productInfo;
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final findInCart = cartController.cartItems
        .firstWhereOrNull((el) => el.modifilerId == productInfo.modifilerId);
    return Slidable(
      key: Key(productInfo.modifilerId),
      endActionPane: !isCart || findInCart == null
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      cartController.deleteItem(productInfo),
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Get.theme.colorScheme.surface,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                'assets/product-default.png',
                fit: BoxFit.cover,
                width: 70.w,
                height: 70.w,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productInfo.name,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        productInfo.price.toStringAsFixed(2),
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      Text(
                        " / unit",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(() => _buildCartButton()),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCartButton() {
    final findInCart = cartController.cartItems
        .firstWhereOrNull((el) => el.modifilerId == productInfo.modifilerId);
    if (cartController.cartItems.isEmpty || findInCart == null) {
      return GestureDetector(
        onTap: () => cartController.addToCart(productInfo),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
          child: Text(
            "Add to cart",
            textAlign: TextAlign.center,
            style: TextStyle(color: Get.theme.colorScheme.surface),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => cartController.decreaseItem(productInfo),
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.all(5.w),
            child: Icon(
              Icons.remove,
              color: Get.theme.colorScheme.surface,
              size: 12.w,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Text(findInCart.quantity.toString()),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () => cartController.increaseItem(productInfo),
          child: Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.all(5.w),
            child: Icon(
              Icons.add,
              color: Get.theme.colorScheme.surface,
              size: 12.w,
            ),
          ),
        ),
      ],
    );
  }
}
