import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';
import 'package:instagram_clone/src/utils/image_path.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadScreen extends GetView<UploadController> {
  const UploadScreen({Key? key}) : super(key: key);

  Widget _imagePreview() {
    var width = Get.width;

    return Obx(() {
      return Container(
          width: width,
          height: width,
          color: Colors.grey,
          child: _photoWidget(
              controller.selectedImage.value,
              width.toInt(),
              false
          )
      );
    });
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: Get.context!,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    ),
                  ),
                  builder: (_) =>
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black54,
                                ),
                                width: 40,
                                height: 4,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: List.generate(
                                      controller.albums.length, (index) =>
                                      GestureDetector(
                                        onTap:(){
                                          Get.back();
                                          controller.changeAlbum(controller.albums[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                          child: Text(
                                              controller.albums[index].name),
                                        ),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Obx(() {
                    return Text(
                      controller.headerTitle.value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),
                    );
                  }),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(width: 7,),
                    const Text(
                      '여러 항목 선택',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff808080)
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(() {
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemCount: controller.imageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  controller.changeSelectedImage(controller.imageList[index]);
                },
                child: _photoWidget(controller.imageList[index], 200, true)
            );
          }
      );
    });
  }

  Widget _photoWidget(AssetEntity asset, int size, bool isThumbnail) {
    AssetType type = controller.selectedImage.value.type;

    if (type == AssetType.image || type == AssetType.video) {
      return FutureBuilder(
          future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Obx(() {
                return Opacity(
                  opacity: (asset == controller.selectedImage.value) &&
                      isThumbnail ? 0.3 : 1,
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                );
              });
            } else {
              return Container();
            }
          }
      );
    } else {
      return Container(
        width: size.toDouble(),
        height: size.toDouble(),
        color: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: Get.back,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.closeImage),
            ),
          ),
          title: const Text(
            'New Post',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                controller.gotoImageFilter();
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ImageData(IconsPath.nextImage, width: 50,),
              ),
            )
          ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
