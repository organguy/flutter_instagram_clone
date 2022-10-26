import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/bindings/init_binding.dart';
import 'package:instagram_clone/src/models/user_model.dart';
import 'package:instagram_clone/src/repository/user_repository.dart';

class AuthController extends GetxController{

  static AuthController get to => Get.find();

  Rx<UserModel> user = UserModel().obs;

  Future<UserModel?> loginUser(String uid) async{
    var userData = await UserRepository.loginUserById(uid);
    if(userData != null){
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  void signup(UserModel signupUser, XFile? thumbnail) async{

    if(thumbnail == null){
      _submitSignup(signupUser);
    }else{
      String fileExtension = thumbnail.path.split('.').last;
      var task = uploadThumbnail(thumbnail, '${signupUser.uid}/profile.$fileExtension');
      task.snapshotEvents.listen((event) async{
        if(event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success){
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedUser = signupUser.copyWith(
            thumbnail: downloadUrl,
          );
          _submitSignup(updatedUser);
        }
      });
    }
  }

  UploadTask uploadThumbnail(XFile xFile, String fileName){
    var file = File(xFile.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(fileName);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path}
    );
    return ref.putFile(file, metadata);
  }

  void _submitSignup(UserModel signupUser) async{
    var result = await UserRepository.signup(signupUser);
    if(result){
      loginUser(signupUser.uid!);
    }
  }
}