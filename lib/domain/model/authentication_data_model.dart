class LoginDataModel {
  const LoginDataModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class RegistrationDataModel {
  const RegistrationDataModel({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;
}
