class UserModel {
  String? accountId;
  String? address;
  String? avatar;
  String? email;
  String? fullname;
  String? password;
  String? phonenumber;
  String? position;

  UserModel(
      {this.accountId,
      this.address,
      this.avatar,
      this.email,
      this.fullname,
      this.password,
      this.phonenumber,
      this.position});

  UserModel.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    address = json['address'];
    avatar = json['avatar'];
    fullname = json['fullname'];
    password = json['password'];
    phonenumber = json['phonenumber'];
    position = json['position'];
  }
}
