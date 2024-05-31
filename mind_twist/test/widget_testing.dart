import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/core/domain/auth/auth_cubit.dart';
import 'package:mind_twist/core/domain/auth/auth_repository_interface.dart';
import 'package:mind_twist/core/domain/auth/auth_state.dart';
import 'package:mind_twist/presentation/screens/admin/admin.dart';
import 'package:mind_twist/presentation/screens/home/home_screen.dart';
import 'package:mind_twist/presentation/screens/profile/profile.dart';
import 'package:mind_twist/presentation/screens/teaser/analytics_screen.dart';
import 'package:mind_twist/presentation/screens/teaser/teaser_screen.dart';
import 'package:mind_twist/presentation/screens/welcome/landing_page.dart';
import 'package:mind_twist/presentation/screens/welcome/signIn.dart';
import 'package:mind_twist/presentation/screens/welcome/signUp.dart';
import 'package:mind_twist/presentation/screens/profile/update_profile.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_twist/main.dart';
import 'package:mind_twist/presentation/screens/home/container.dart';

@GenerateMocks([AuthRepositoryInterface])
void main() {
  group('MindTwist App Widget Tests', () {
    late MockAuthRepositoryInterface mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepositoryInterface();
    });

    testWidgets('LandingPage renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LandingPage(),
        ),
      );

      expect(find.text('MIND-TWIST'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
    });

    testWidgets('SignInScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const SignInScreen(),
          ),
        ),
      );

      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('SignUpScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const SignUpScreen(),
          ),
        ),
      );

      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('HomeScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.text('Welcome to MindTwist!'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(5));
    });

    testWidgets('TeaserScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const TeaserScreen(),
          ),
        ),
      );

      expect(find.text('Choose a category to play'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AnalyticsScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const AnalyticsScreen(),
          ),
        ),
      );

      expect(
          find.text('Your analytics will be displayed here'), findsOneWidget);
    });

    testWidgets('ProfileScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const ProfileScreen(),
          ),
        ),
      );

      expect(find.text('Your profile information'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('UpdateProfileScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const UpdateProfileScreen(),
          ),
        ),
      );

      expect(find.text('Update your profile information here'), findsOneWidget);
    });

    testWidgets('AdminScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepository: mockAuthRepository),
            child: const AdminScreen(),
          ),
        ),
      );

      expect(find.text('Admin panel functionalities'), findsOneWidget);
    });

    testWidgets('MainContainer renders HomeScreen when authenticated',
        (tester) async {
      when(mockAuthRepository.signOut()).thenAnswer((_) async {});
      final authCubit = AuthCubit(authRepository: mockAuthRepository);
      authCubit.emit(AuthenticationSuccess()); // Emit authenticated state

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: authCubit,
            child: const MainContainer(),
          ),
        ),
      );

      expect(find.text('Welcome to MindTwist!'), findsOneWidget);
    });

    testWidgets('MainContainer renders LandingPage when not authenticated',
        (tester) async {
      final authCubit = AuthCubit(authRepository: mockAuthRepository);
      authCubit.emit(AuthInitial()); // Emit initial state (not authenticated)

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: authCubit,
            child: const MainContainer(),
          ),
        ),
      );

      expect(find.text('MIND-TWIST'), findsOneWidget);
    });
  });
}
