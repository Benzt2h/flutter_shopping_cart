import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/models/product_info.dart';
import 'package:shopping_cart/modules/shopping/controller/shopping_controller.dart';
import 'package:shopping_cart/widgets/error_refresh_widget.dart';
import 'package:shopping_cart/widgets/product_loading_widget.dart';
import 'package:shopping_cart/widgets/product_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShoppingPage extends GetView<ShoppingController> {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: EdgeInsets.only(bottom: 120.h),
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              _buildRecmmend(),
              SizedBox(height: 20.h),
              _buildLatest(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLatest() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Latest Products",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
        Obx(() => _buildLatestProducts()),
      ],
    );
  }

  Widget _buildLatestProducts() {
    if (controller.errorMessageLatest.isNotEmpty) {
      return ErrorRefreshWidget(onRefresh: controller.getLatestProducts);
    } else {
      return Column(
        children: [
          Skeletonizer(
            enabled: controller.isLoadingLatest.value,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.isLoadingLatest.value
                  ? 5
                  : controller.latestProducts.length,
              itemBuilder: (context, index) {
                if (controller.isLoadingLatest.value) {
                  return ProductLoadingWidget();
                }
                ProductInfo productInfo = controller.latestProducts[index];
                return ProductWidget(productInfo: productInfo);
              },
            ),
          ),
          Obx(
            () => !controller.isLoadingMoreLatest.value
                ? SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 5.w),
                      Text("Loading...")
                    ],
                  ),
          )
        ],
      );
    }
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
    if (controller.errorMessageRecommended.isNotEmpty) {
      return ErrorRefreshWidget(onRefresh: controller.getRecommendedProducts);
    } else {
      return Skeletonizer(
        enabled: controller.isLoadingRecommended.value,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.isLoadingRecommended.value
              ? 5
              : controller.recommendedProducts.length,
          itemBuilder: (context, index) {
            if (controller.isLoadingRecommended.value) {
              return ProductLoadingWidget();
            }
            ProductInfo productInfo = controller.recommendedProducts[index];
            return ProductWidget(productInfo: productInfo);
          },
        ),
      );
    }
  }
}
