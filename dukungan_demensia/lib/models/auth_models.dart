class LoginRequestBody {
  final String username;
  final String password;

  const LoginRequestBody({
    required this.username, 
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}

class RegisterRequestBody {
  final String email;
  final String name;
  final String role;
  final String username;
  final String password;
  final String phoneNumber;
  final String? caregiverUsername;

  const RegisterRequestBody({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.role,
    required this.phoneNumber,
    this.caregiverUsername,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'username': username,
      'password': password,
      'email': email,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
    };

    if (caregiverUsername != null) {
      json['caregiverUsername'] = caregiverUsername;
    }

    return json;
  }
}
