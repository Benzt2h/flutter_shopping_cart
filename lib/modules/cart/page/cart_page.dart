import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/modules/cart/controller/cart_controller.dart';
import 'package:shopping_cart/widgets/product_widget.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Obx(
        () => controller.isCheckOrderSuccess.value
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Success!",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Thank you for shopping with us!",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.w),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "Shop again",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : controller.cartItems.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Empty Cart",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.w),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Get.theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text("Go to shopping",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            bottom: 120.h,
                            right: 10.w,
                          ),
                          itemCount: controller.cartItems.length,
                          itemBuilder: (context, index) {
                            ProductInfo productInfo =
                                controller.cartItems[index];
                            return ProductWidget(
                                productInfo: productInfo, isCart: true);
                          },
                        ),
                      ),
                      Container(
                        height: 200.h,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.w, horizontal: 20.w),
                        decoration:
                            BoxDecoration(color: Get.theme.primaryColor),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.surface,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    controller.sumPrice.value
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.surface,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Promotion discount",
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.surface,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    "-${controller.discountPrice.value.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    (controller.sumPrice.value -
                                            controller.discountPrice.value)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.surface,
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await controller.postCheckout();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Get.theme.colorScheme.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Text(
                                    "Checkout",
                                    style: TextStyle(
                                      color: Get.theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
