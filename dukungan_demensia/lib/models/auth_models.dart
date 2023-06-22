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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      username: json['username'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
    );
  }
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
      user: User.fromJson(json['user'] as Map<String, dynamic>) 
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
  String? careGiverUsername;

  RegisterRequestBody({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.role,
    required this.phoneNumber,
    this.careGiverUsername,
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

    if (careGiverUsername != null) {
      json['careGiverUsername'] = careGiverUsername;
    }

    return json;
  }
}

class RegisterResponseBody {
  User? user;

  RegisterResponseBody({
    this.user,
  });

  factory RegisterResponseBody.fromJson(Map<String, dynamic> json) {
    return RegisterResponseBody(
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }
}

