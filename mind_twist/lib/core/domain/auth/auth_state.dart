abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthenticationSuccess extends AuthState {}

class AuthenticationFailure extends AuthState {
  final String message;

  AuthenticationFailure({required this.message});
}
