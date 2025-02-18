import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';

class ErrorRefreshWidget extends StatelessWidget {
  const ErrorRefreshWidget({
    super.key,
    required this.onRefresh,
  });

  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: 10.h),
        ElevatedButton(
          onPressed: () => onRefresh(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Get.theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text("Refresh",
              style: TextStyle(color: Get.theme.colorScheme.surface)),
        ),
      ],
    );
  }
}
