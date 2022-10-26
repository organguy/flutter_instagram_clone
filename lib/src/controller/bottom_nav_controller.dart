import 'dart:io';

import 'package:get/get.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';
import 'package:instagram_clone/src/screens/upload_screen.dart';
import 'package:flutter/material.dart';

enum PageName{home, search, upload, activity, myPage}

class BottomNavController extends GetxController{
  static BottomNavController get to => Get.find();
  GlobalKey<NavigatorState> searchNavigationKey = GlobalKey<NavigatorState>();
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch(page){
      case PageName.upload:
        Get.to(() => const UploadScreen(), binding: BindingsBuilder(() {
          Get.put(UploadController());
        }));
        break;
      case PageName.home:
      case PageName.search:
      case PageName.activity:
      case PageName.myPage:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);

    if(!hasGesture){
      debugPrint(bottomHistory.toString());
      return;
    }

    if(bottomHistory.contains(value)){
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
    debugPrint(bottomHistory.toString());
  }

  Future<bool> willPopAction() async {
    if(bottomHistory.length == 1){
      //debugPrint('exit');

      showDialog(context: Get.context!, builder: (context)
          => MessagePopup(
              title: 'System',
              message: 'Exit App?',
              okCallback: () => exit(0),
              cancelCallback: Get.back,
          )
      );

      return true;
    }else {

      var page = PageName.values[bottomHistory.last];
      if(page == PageName.search){
        var value = await searchNavigationKey.currentState!.maybePop();
        if(value){
          return false;
        }
      }

      bottomHistory.removeLast();
      int index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}