import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductLoadingWidget extends StatelessWidget {
  const ProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  "loading...",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      "loading...",
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
        ],
      ),
    );
  }
}
