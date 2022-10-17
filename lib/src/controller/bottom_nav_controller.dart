import 'dart:io';

import 'package:get/get.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/screens/upload.dart';
import 'package:flutter/material.dart';

enum PageName{HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE}

class BottomNavController extends GetxController{
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch(page){
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
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
      bottomHistory.removeLast();
      int index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}