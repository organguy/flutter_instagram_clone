import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/models/user_model.dart';
import 'package:instagram_clone/src/repository/user_repository.dart';

class AuthController extends GetxController{

  static AuthController get to => Get.find();

  Rx<UserModel> user = UserModel().obs;

  Future<UserModel?> loginUser(String uid) async{
    var userData = UserRepository.loginUserById(uid);
    return userData;
  }

  void signup(UserModel signupUser) async{
    var result = await UserRepository.signup(signupUser);
    if(result){
      user(signupUser);
    }
  }
}