import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/components/post_widget.dart';
import 'package:instagram_clone/src/utils/image_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _myStory(){
    return Stack(
      children: [
        const AvatarWidget(
          type: AvatarType.TYPE2,
          thumbPath: 'https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg',
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: Colors.white,
                width: 2
              )
            ),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.1
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
            const SizedBox(width: 20,),
            _myStory(),
            const SizedBox(width: 5,),
            ...List.generate(100, (index) => const AvatarWidget(
              type: AvatarType.TYPE1,
              thumbPath: 'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg',
            )),
          ]
        ),
      );
  }

  Widget _postList() {
    return Column(
      children: List.generate(50, (index) => const PostWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList()
        ],
      ),
    );
  }


}
