class User {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;
  String? email;
  String? name;
  String? phoneNumber;
  String? role;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.email,
    this.name,
    this.phoneNumber,
    this.role,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'username': username,
    'email': email,
    'name': name,
    'phoneNumber': phoneNumber,
    'role': role,
  };
}

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

class LoginResponseBody {
  String? token;
  User? user;

  LoginResponseBody({
    this.user, 
    this.token
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) {
    return LoginResponseBody(
      token: json['token'] as String?,
      user: json['user'] as User?,
    );
  }
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
