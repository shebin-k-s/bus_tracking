class AuthReqParams {
  String? fullName;
  String? email;
  String? password;

  AuthReqParams({
    this.fullName,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }
}
