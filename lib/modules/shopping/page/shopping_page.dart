import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/modules/shopping/controller/shopping_controller.dart';
import 'package:shopping_cart/widgets/product_loading_widget.dart';
import 'package:shopping_cart/widgets/product_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShoppingPage extends GetView<ShoppingController> {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildRecmmend(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecmmend() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Recommend Products",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
        Obx(() => _buildRecmmendProducts()),
      ],
    );
  }

  Widget _buildRecmmendProducts() {
    if (controller.isLoadingRecommended.value) {
      return Skeletonizer(
        enabled: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ProductLoadingWidget();
          },
        ),
      );
    } else if (controller.errorMessageRecommended.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 50.w, color: Colors.red),
          SizedBox(height: 10.h),
          Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.w),
          ElevatedButton(
            onPressed: () {
              controller.getRecommendedProducts();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text("Refresh", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: controller.recommendedProducts.length,
        itemBuilder: (context, index) {
          ProductInfo productInfo = controller.recommendedProducts[index];
          return ProductWidget(productInfo: productInfo);
        },
      );
    }
  }
}
