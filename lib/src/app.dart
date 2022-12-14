import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:instagram_clone/src/screens/active_screen.dart';
import 'package:instagram_clone/src/screens/home_screen.dart';
import 'package:instagram_clone/src/screens/my_screen.dart';
import 'package:instagram_clone/src/screens/search_screen.dart';
import 'package:instagram_clone/src/utils/image_path.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(() {
        return Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const HomeScreen(),
              Navigator(
                key: controller.searchNavigationKey,
                onGenerateRoute: (routeSetting){
                  return MaterialPageRoute(
                    builder: (context) => const SearchScreen()
                  );
                },
              ),
              Container(),
              const ActiveScreen(),
              const MyScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            onTap: controller.changeBottomNav,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'search'
              ),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(AuthController.to.user.value.thumbnail!),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  label: 'home'
              ),
            ],
          ),
        );
      }),
    );
  }
}
