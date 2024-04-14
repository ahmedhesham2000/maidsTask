class UserData {
  int? id;
  String? userName;
  String? password;
  String? token;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? userImg;
  UserData(
      {this.id,
      this.userName,
      this.password,
      this.token,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.userImg});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    userImg = json['image'];
    token = json['token'];
  }
}
