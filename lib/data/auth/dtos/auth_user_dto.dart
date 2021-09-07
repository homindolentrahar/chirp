import 'package:supabase/supabase.dart';

class AuthUserDto {
  final String userId;
  final String email;
  final String createdAt;
  final String lastSignAt;

  AuthUserDto({
    required this.userId,
    required this.email,
    required this.createdAt,
    required this.lastSignAt,
  });

  factory AuthUserDto.fromUser(User? user) => AuthUserDto(
        userId: user?.id ?? "No ID",
        email: user?.email ?? "No Email",
        createdAt: user?.createdAt ?? DateTime.now().toIso8601String(),
        lastSignAt: user?.lastSignInAt ?? DateTime.now().toIso8601String(),
      );
}
