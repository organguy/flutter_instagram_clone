import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({Key? key}) : super(key: key);

  Widget _activeItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          AvatarWidget(
            type: AvatarType.TYPE2,
            size: 40,
            thumbPath: 'https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg'
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'organguy',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: '님이 회원님의 게시물을 좋아합니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal
                    )
                  ),
                  TextSpan(
                    text: ' 5 일전',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54
                    )
                  )
                ]
              )
            )
          )
        ],
      ),
    );
  }

  Widget _activeList(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16
            ),
          ),
          const SizedBox(height: 15,),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _activeList('오늘'),
            _activeList('이번주'),
            _activeList('이번달'),
          ],
        ),
      ),
    );
  }
}
