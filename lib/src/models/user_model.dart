class UserModel{
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;

  UserModel({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description
    };
  }

  UserModel copyWith({
    String? uid,
    String? nickname,
    String? thumbnail,
    String? description,
  }){
    return UserModel(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
    );
  }
}