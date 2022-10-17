import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/bottom_item_image_data.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: const [
              Center(child: Text('HOME')),
              Center(child: Text('SEARCH')),
              Center(child: Text('UPLOAD')),
              Center(child: Text('ACTIVITY')),
              Center(child: Text('MY PAGE')),
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
                  icon: BottomItemImageData(IconsPath.homeOff),
                  activeIcon: BottomItemImageData(IconsPath.homeOn),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: BottomItemImageData(IconsPath.searchOff),
                  activeIcon: BottomItemImageData(IconsPath.searchOn),
                  label: 'search'
              ),
              BottomNavigationBarItem(
                  icon: BottomItemImageData(IconsPath.uploadIcon),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: BottomItemImageData(IconsPath.activeOff),
                  activeIcon: BottomItemImageData(IconsPath.activeOn),
                  label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey
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
