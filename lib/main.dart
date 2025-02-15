import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/modules/cart/page/cart_page.dart';
import 'package:shopping_cart/modules/home/binding/home_binding.dart';
import 'package:shopping_cart/modules/home/page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375.0, 812.0),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping Cart',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          initialRoute: '/home',
          getPages: [
            GetPage(
              name: '/home',
              page: () => HomePage(),
              binding: HomeBinding(),
            ),
            GetPage(
              name: '/cart',
              page: () => CartPage(),
            ),
          ],
        );
      },
    );
  }
}
