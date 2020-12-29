import 'package:hello_world/models/user_model.dart';

abstract class AuthState {
  get user => null;
}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
