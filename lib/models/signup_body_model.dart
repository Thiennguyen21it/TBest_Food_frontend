class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  //contructor
  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  //convert to json method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
