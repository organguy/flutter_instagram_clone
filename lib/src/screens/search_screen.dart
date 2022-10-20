
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/screens/search_focus_screen.dart';
import 'package:quiver/iterables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<List<int>> groupBox = [[],[],[]];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    for(var i = 0; i < 100; i++){

      var gridIndex = groupIndex.indexOf(min<int>(groupIndex)!);
      var size = 1;

      if(gridIndex != 1){
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }

      groupBox[gridIndex].add(size);
      groupIndex[gridIndex] += size;
    }

    debugPrint(groupBox.toString());

  }

  Widget _appbar(){
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SearchFocusScreen())
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffefefef),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff838383)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        )
      ],
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(groupBox.length, (index) =>
          Expanded(
            child: Column(
              children: List.generate(groupBox[index].length, (jndex) => Container(
                  height: Get.width * 0.33 * groupBox[index][jndex],
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.primaries[
                      Random().nextInt(Colors.primaries.length)
                    ]
                  ),
                  child: CachedNetworkImage(
                    imageUrl: 'https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
            ),
          ),
        )
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(),
            Expanded(
              child: _body()
            ),
          ],
        ),
      ),
    );
  }
}
