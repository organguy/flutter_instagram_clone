import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/models/user_model.dart';

class PostModel{
  final String? id;
  final String? thumbnail;
  final String? description;
  final int? likeCount;
  final int? replyCount;
  final UserModel? userInfo;
  final String? uid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  PostModel({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    this.replyCount,
    this.userInfo,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PostModel.init(UserModel userInfo){
    var time = DateTime.now();
    return PostModel(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      createdAt: time,
      updatedAt: time,
    );
  }

  factory PostModel.fromJson(String docId, Map<String, dynamic> json){
    return PostModel(
      id: json['id'] == null ? '' : json['id'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
      likeCount: json['likeCount'] == null ? 0 : json['likeCount'] as int,
      replyCount: json['replyCount'] == null ? 0 : json['replyCount'] as int,
      uid: json['uid'] == null ? '' : json['uid'] as String,
      userInfo: json['userInfo'] == null ? null : UserModel.fromJson(json['userInfo']),
      createdAt: json['createdAt'] == null ? DateTime.now() : json['createdAt'].toDate(),
      updatedAt: json['updatedAt'] == null ? DateTime.now() : json['updatedAt'].toDate(),
      deletedAt: json['deletedAt'] = json['deletedAt']?.toDate(),
    );
  }

  PostModel copyWith({
    String? id,
    String? thumbnail,
    String? description,
    int? likeCount,
    int? replyCount,
    UserModel? userInfo,
    String? uid,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }){
    return PostModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      userInfo: userInfo ?? this.userInfo,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'thumbnail' : thumbnail,
      'description' : description,
      'likeCount' : likeCount,
      'replyCount' : replyCount,
      'userInfo' : userInfo!.toMap(),
      'uid' : uid,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt,
      'deletedAt' : deletedAt,
    };
  }
}