


class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? uId;
  String? image;


  UserModel(
      {
        this.uId,
        this.firstName,
        this.lastName,
        this.email,
        this.image,

      });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'uId': uId,
      'image': image,
    };
  }
}