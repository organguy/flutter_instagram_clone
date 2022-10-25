import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/models/user_model.dart';

class UserRepository{
  static Future<UserModel?> loginUserById(String uid) async{
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if(data.size == 0){
      return null;
    }else{
      UserModel? userModel = UserModel.fromJson(data.docs.first.data());
      return userModel;
    }
  }

  static Future<bool> signup(UserModel user) async{
    try{
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    }catch(e){
      return false;
    }

  }
}