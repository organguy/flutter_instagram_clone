import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/models/post_model.dart';
import 'package:instagram_clone/src/repository/post_repository.dart';
import 'package:instagram_clone/src/screens/home_screen.dart';
import 'package:instagram_clone/src/screens/upload_post_screen.dart';
import 'package:instagram_clone/src/utils/utils.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/photofilters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
class UploadController extends GetxController{

  var albums = <AssetPathEntity>[];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  RxString headerTitle = ''.obs;
  Rx<AssetEntity> selectedImage = const AssetEntity(
      id: '0',
      typeInt: 0,
      width: 0,
      height: 0
  ).obs;

  TextEditingController textEditingController = TextEditingController();

  File? filteredImage;
  PostModel? post;

  @override
  void onInit() {
    super.onInit();
    post = PostModel.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async{
    var result = await PhotoManager.requestPermissionExtend();
    if(result.isAuth){
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                sizeConstraint: SizeConstraint(
                    minHeight: 100,
                    minWidth: 100
                ),
              ),
              orders: [
                const OrderOption(
                    type: OrderOptionType.createDate,
                    asc: false
                )
              ]
          )
      );
      _loadData();
    }else{
      // message 권한 요청
    }
  }

  void _loadData(){
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async{
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList(photos);
    selectedImage(imageList.first);
  }

  void changeSelectedImage(AssetEntity image){
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async{
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void gotoImageFilter() async{
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    var imageFile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(builder: (context) => PhotoFilterSelector(
          title: const Text('Photo Filter Sample'),
          filters: presetFiltersList,
          image: image!,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator(),),
          fit: BoxFit.cover,
      ))
    );

    if(imageFile.containsKey('image_filtered')){
      filteredImage = imageFile['image_filtered'];
      Get.to(() => const UploadPostScreen());
    }
  }

  void unfocusKeyboard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost(){
    unfocusKeyboard();
    String fileName = Utils.makeFilePath(filteredImage!.path);
    var task = uploadThumbnail(filteredImage!, fileName);
    task.snapshotEvents.listen((event) async{
      if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success){
        var downloadUrl = await event.ref.getDownloadURL();
        var updatedPost = post!.copyWith(
          thumbnail: downloadUrl,
          description: textEditingController.text,
        );
        _submitPost(updatedPost);
      }
    });
  }

  UploadTask uploadThumbnail(File file, String fileName){
    var ref = FirebaseStorage.instance.ref()
        .child('instagram')
        .child(AuthController.to.user.value.uid!)
        .child(fileName);

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path}
    );
    return ref.putFile(file, metadata);
  }

  void _submitPost(PostModel postModel) async{
    await PostRepository.updatePost(postModel);
    showDialog(context: Get.context!, builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료되었습니다.',
        okCallback: (){
          Get.offAll(const HomeScreen());
        }
      )
    );
  }
}