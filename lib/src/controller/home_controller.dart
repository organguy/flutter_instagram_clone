import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/models/post_model.dart';
import 'package:instagram_clone/src/repository/post_repository.dart';

class HomeController extends GetxController with WidgetsBindingObserver{

  RxList<PostModel> posts = <PostModel>[].obs;

  static HomeController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadPostList();
  }

  void _loadPostList() async{
    var postList = await PostRepository.loadPostList();
    posts(postList);
  }
}