class UserModel {
  final String? email;
  final String? password;
  final String? uId;
  final String? userName;

  UserModel({
    this.email = '',
    this.password = '',
    this.uId = '',
    this.userName = '',
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? uId,
    String? userName,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      uId: uId ?? this.uId,
      userName: userName ?? this.userName,
    );
  }
}
