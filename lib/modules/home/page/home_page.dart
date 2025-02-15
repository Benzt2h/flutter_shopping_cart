import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:refreshed/refreshed.dart';
import 'package:shopping_cart/modules/home/controller/home_controller.dart';
import 'package:shopping_cart/modules/shopping/page/shopping_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          tabs: [
            PersistentTabConfig(
              screen: ShoppingPage(),
              item: ItemConfig(
                icon: Icon(Icons.home),
                title: "Shopping",
              ),
            ),
            PersistentTabConfig(
              screen: SizedBox.shrink(),
              item: ItemConfig(
                icon: Icon(Icons.shopping_cart),
                title: "Cart",
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: NavBarConfig(
              selectedIndex: navBarConfig.selectedIndex,
              items: navBarConfig.items,
              onItemSelected: (int index) {
                if (index == 1) {
                  controller.routeToCart();
                  return;
                }
                navBarConfig.onItemSelected(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
