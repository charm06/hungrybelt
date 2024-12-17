import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungrybelt/pages/home_page.dart';
import 'package:hungrybelt/pages/favorite_page.dart';
import 'package:hungrybelt/pages/spin_wheel_page.dart';
import 'package:hungrybelt/pages/space_page.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppRouterController());

    return Scaffold(
      /*appBar: AppBar(
        title: Obx(
          () {
            final titles = ['uHome', 'uFaves', 'uSpin', 'uSpace'];
            return Text(
              titles[controller.selectedIndex.value],
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            );
          },
        ),
        centerTitle: false,
      ),*/
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => controller.screens[controller.selectedIndex.value]),
        ),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Obx(
            () => NavigationBar(
              backgroundColor: const Color(0xFF0d1282),
              height: 90,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              indicatorColor: Colors.transparent,
              destinations: [
                _buildCustomNavigationDestination(
                    controller.selectedIndex.value,
                    0,
                    Image.asset(
                      "assets/images/home_nav_logo.png",
                      width: 50.0,
                      height: 50.0,
                    )),
                _buildCustomNavigationDestination(
                    controller.selectedIndex.value,
                    1,
                    Image.asset(
                      "assets/images/fave_nav_logo.png",
                      width: 50.0,
                      height: 50.0,
                    )),
                _buildCustomNavigationDestination(
                    controller.selectedIndex.value,
                    2,
                    Image.asset(
                      "assets/images/wheel_nav_logo.png",
                      width: 50.0,
                      height: 50.0,
                    )),
                _buildCustomNavigationDestination(
                    controller.selectedIndex.value,
                    3,
                    Image.asset(
                      "assets/images/space_nav_logo.png",
                      width: 50.0,
                      height: 50.0,
                    )),
                _buildCustomNavigationDestination(
                    controller.selectedIndex.value,
                    4,
                    Image.asset(
                      "assets/images/profile_logo.png",
                      width: 50.0,
                      height: 50.0,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  NavigationDestination _buildCustomNavigationDestination(
      int currentIndex, int index, dynamic icon) {
    return NavigationDestination(
      icon: Container(
        padding: EdgeInsets.zero, // Remove any unnecessary padding
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: _buildIcon(icon, currentIndex == index),
      ),
      label: '', // Keep the label empty to remove text
    );
  }

  Widget _buildIcon(dynamic icon, bool isSelected) {
    if (icon is IconData) {
      // Render IconData (for Material Icons)
      return Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.blueAccent : const Color(0xFFEEEDED),
      );
    } else if (icon is Image) {
      // Render ImageIcon (for custom images)
      return icon; // Directly return ImageIcon widget
    }
    return const SizedBox.shrink(); // If neither, return an empty widget
  }
}

class AppRouterController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const FavoritePage(),
    const SpinWheelPage(),
    const SpacePage(),
    const ProfileScreen()
  ];
}
