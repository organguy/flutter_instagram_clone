import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/models/user_model.dart';

class MyController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<UserModel> targetUser = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void setTargetUser(){
    var uid = Get.parameters['targetUid'];
    if(uid == null){
      targetUser(AuthController.to.user.value);
    }else{
      // 다른 사람 uid로 조회
    }
  }

  void _loadData(){
    setTargetUser();
  }
}