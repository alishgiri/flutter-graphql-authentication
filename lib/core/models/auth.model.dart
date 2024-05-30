import 'package:jwt_decode/jwt_decode.dart';

import 'package:auth_app/core/models/auth_data.model.dart';

class Auth {
  final String name;
  final String userId;
  final String accessToken;
  final String refreshToken;

  const Auth({
    required this.name,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Auth.fromJson(Map<String, dynamic> data) {
    final jwt = Jwt.parseJwt(data["accessToken"]);
    return Auth(
      name: jwt["name"],
      userId: jwt["iss"],
      accessToken: data["accessToken"],
      refreshToken: data["refreshToken"],
    );
  }

  factory Auth.fromAuthData(AuthData data) {
    final jwt = Jwt.parseJwt(data.accessToken!);
    return Auth(
      name: jwt["name"],
      userId: jwt["iss"],
      accessToken: data.accessToken!,
      refreshToken: data.refreshToken!,
    );
  }
}
