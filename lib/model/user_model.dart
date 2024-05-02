class APIModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  APIModel({this.userId, this.id, this.title, this.body});

  APIModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class APIImageModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  APIImageModel(
      {this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  APIImageModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

// class User {
//   final String gender;
//   final String email;
//   final String phone;
//   final String cell;
//   final String nat;
//   final UserName name;
//   User(
//       {required this.gender,
//       required this.email,
//       required this.phone,
//       required this.cell,
//       required this.nat,
//       required this.name});
// }
//
// class UserName {
//   final String title;
//   final String first;
//   final String last;
//
//   UserName({required this.title, required this.first, required this.last});
// }
