import 'package:bloc/bloc.dart';
import 'package:mind_twist/core/domain/auth/auth_repository_interface.dart';
import 'package:mind_twist/core/domain/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryInterface authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  void signUp({required String username, required String password}) async {
    emit(AuthLoading());
    try {
      await authRepository.signUp(username: username, password: password);
      emit(AuthenticationSuccess());
    } catch (e) {
      emit(AuthenticationFailure(message: 'Signup failed: $e'));
    }
  }

  void signIn({required String username, required String password}) async {
    emit(AuthLoading());
    try {
      await authRepository.signIn(username: username, password: password);
      emit(AuthenticationSuccess());
    } catch (e) {
      emit(AuthenticationFailure(message: 'Signin failed: $e'));
    }
  }

  void signOut() async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthenticationFailure(message: 'Signout failed: $e'));
    }
  }
}
