import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/utils/image_path.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  Widget _header(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AvatarWidget(
            type: AvatarType.TYPE3,
            nickname: 'organguy',
            size: 40,
            thumbPath: 'https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg'
          ),
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image(){
    return CachedNetworkImage(
      imageUrl: 'https://images.pexels.com/photos/589840/pexels-photo-589840.jpeg?cs=srgb&dl=pexels-valiphotos-589840.jpg&fm=jpg'
    );
  }

  Widget _infoCount(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              const SizedBox(width: 15,),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              const SizedBox(width: 15,),
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 50,
          ),
        ],
      ),
    );
  }

  Widget _infoDescription(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '좋아요 150개',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          ExpandableText(
            '콘텐츠1입니다.\n콘텐츠1입니다.\n콘텐츠1입니다.\n콘텐츠1입니다.\n콘텐츠1입니다.\n',
            prefixText: 'organguy',
            onPrefixTap: (){
              debugPrint('organguy page');
            },
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.bold
            ),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn(){
    return GestureDetector(
      onTap: (){},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 199개 모두 보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13
          ),
        ),
      ),
    );
  }

  Widget _dateAgo(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '1일전',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(height: 15,),
          _image(),
          const SizedBox(height: 15,),
          _infoCount(),
          const SizedBox(height: 5,),
          _infoDescription(),
          const SizedBox(height: 5,),
          _replyTextBtn(),
          const SizedBox(height: 5,),
          _dateAgo(),
        ],
      ),
    );
  }
}
