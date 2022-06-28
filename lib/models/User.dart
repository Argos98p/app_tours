class User {
  int? id;
  String? username;
  String? email;
  List<String>? roles;
  String? accessToken;
  String? tokenType;

  User(
      {required this.id,
        required this.username,
        required this.email,
        required this.roles,
        required this.accessToken,
        required this.tokenType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roles = json['roles'].cast<String>();
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['roles'] = roles;
    data['accessToken'] = accessToken;
    data['tokenType'] = tokenType;
    return data;
  }
}