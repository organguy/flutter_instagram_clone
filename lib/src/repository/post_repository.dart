import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/models/post_model.dart';

class PostRepository{
  static Future<void> updatePost(PostModel post) async{
    await FirebaseFirestore.instance.collection('posts').add(post.toMap());
  }

  static Future<List<PostModel>> loadPostList() async{
    var document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(10);

    var data = await document.get();
    return data.docs.map<PostModel>((e) =>
        PostModel.fromJson(e.id, e.data())).toList();
  }
}