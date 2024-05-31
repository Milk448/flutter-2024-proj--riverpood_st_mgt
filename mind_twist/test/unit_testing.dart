import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/core/domain/auth/auth_cubit.dart';
import 'package:mind_twist/core/domain/auth/auth_repository_interface.dart';
import 'package:mind_twist/core/domain/auth/auth_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthRepositoryInterface])
void main() {
  group('AuthCubit Tests', () {
    late AuthCubit authCubit;
    late MockAuthRepositoryInterface mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepositoryInterface();
      authCubit = AuthCubit(authRepository: mockAuthRepository);
    });

    group('SignUp', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthenticationSuccess] when signUp is successful',
        build: () => authCubit,
        act: (cubit) =>
            cubit.signUp(username: 'testuser', password: 'testpassword'),
        expect: () => [
          AuthLoading(),
          AuthenticationSuccess(),
        ],
        verify: (cubit) {
          verify(mockAuthRepository.signUp(
                  username: 'testuser', password: 'testpassword'))
              .called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthenticationFailure] when signUp fails',
        build: () => authCubit,
        act: (cubit) =>
            cubit.signUp(username: 'testuser', password: 'testpassword'),
        expect: () => [
          AuthLoading(),
          AuthenticationFailure(
              message: 'Signup failed: Exception: Some error'),
        ],
        verify: (cubit) {
          verify(mockAuthRepository.signUp(
                  username: 'testuser', password: 'testpassword'))
              .called(1);
        },
        setUp: () {
          when(mockAuthRepository.signUp(
                  username: 'testuser', password: 'testpassword'))
              .thenThrow(Exception('Some error'));
        },
      );
    });

    group('SignIn', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthenticationSuccess] when signIn is successful',
        build: () => authCubit,
        act: (cubit) =>
            cubit.signIn(username: 'testuser', password: 'testpassword'),
        expect: () => [
          AuthLoading(),
          AuthenticationSuccess(),
        ],
        verify: (cubit) {
          verify(mockAuthRepository.signIn(
                  username: 'testuser', password: 'testpassword'))
              .called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthenticationFailure] when signIn fails',
        build: () => authCubit,
        act: (cubit) =>
            cubit.signIn(username: 'testuser', password: 'testpassword'),
        expect: () => [
          AuthLoading(),
          AuthenticationFailure(
              message: 'Signin failed: Exception: Some error'),
        ],
        verify: (cubit) {
          verify(mockAuthRepository.signIn(
                  username: 'testuser', password: 'testpassword'))
              .called(1);
        },
        setUp: () {
          when(mockAuthRepository.signIn(
                  username: 'testuser', password: 'testpassword'))
              .thenThrow(Exception('Some error'));
        },
      );
    });

    group('SignOut', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthInitial] when signOut is successful',
        build: () => authCubit,
        act: (cubit) => cubit.signOut(),
        expect: () => [
          AuthLoading(),
          AuthInitial(),
        ],
        verify: (cubit) {
          verify(mockAuthRepository.signOut()).called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthenticationFailure] when signOut fails',
        build: () => authCubit,
        act: (cubit) => cubit.signOut(),
        expect: () => [
          AuthLoading(),
          AuthenticationFailure(
              message: 'Signout failed: Exception: Some error'),
        ],
        verify: (cubit) {
          verify(mockAuthRepository.signOut()).called(1);
        },
        setUp: () {
          when(mockAuthRepository.signOut()).thenThrow(Exception('Some error'));
        },
      );
    });
  });
}
