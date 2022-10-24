import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/utils/imagepath.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  var albums = <AssetPathEntity>[];
  var imageList = <AssetEntity>[];
  var headerTitle = '';
  AssetEntity? selectedImage;

  @override
  void initState() {
    super.initState();
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

  void _loadData() async{
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  Future<void> _pagingPhotos() async{
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    selectedImage = imageList.first;
  }

  void update() => setState(() {});


  Widget _imagePreview(){

    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: width,
      color: Colors.grey,
      child: selectedImage == null
          ? Container()
          : _photoWidget(selectedImage!, width.toInt(), false)
    );
  }

  Widget _header(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    ),
                  ),
                  builder: (_) => Expanded(
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(albums.length, (index) => Container(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                child: Text(albums[index].name),
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
                  Text(
                    headerTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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

  Widget _imageSelectList(){
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: imageList.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
            selectedImage = imageList[index];
            update();
          },
          child: _photoWidget(imageList[index], 200, true)
        );
      }
    );
  }

  Widget _photoWidget(AssetEntity asset, int size, bool isThumbnail){
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_, snapshot){
        if(snapshot.hasData){
          return Opacity(
            opacity: (asset == selectedImage) && isThumbnail ? 0.3 : 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        }else{
          return Container();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){},
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
            onTap: (){},
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
