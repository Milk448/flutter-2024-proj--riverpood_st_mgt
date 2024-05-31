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
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'integration_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('MindTwist App Integration Tests', () {
    late MockAuthRepository mockAuthRepository;
    late SharedPreferences mockSharedPreferences;
    late HttpServer mockHttpServer;

    setUp(() async {
      mockAuthRepository = MockAuthRepository();
      mockSharedPreferences =
          SharedPreferences.getInstance() as SharedPreferences;
      // Set up mock HTTP server (use a library like `mockito` or `http_mock`)
      mockHttpServer = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      // Configure mock HTTP server endpoints and responses
      // (See example below)
    });

    tearDown(() async {
      await mockHttpServer.close(force: true);
    });

    // Test the entire app flow from landing page to various screens
    testWidgets('Complete App Flow', (tester) async {
      // Configure mock HTTP server for authentication
      when(mockAuthRepository.signUp(
              username: anyNamed('username'), password: anyNamed('password')))
          .thenAnswer((_) async {
        // Mock successful signup
        final response = http.Response(
            jsonEncode({'token': 'mock_token', 'userId': 'mock_user_id'}), 201);
        return response;
      });

      when(mockAuthRepository.signIn(
              username: anyNamed('username'), password: anyNamed('password')))
          .thenAnswer((_) async {
        // Mock successful sign-in
        final response = http.Response(
            jsonEncode({'token': 'mock_token', 'userId': 'mock_user_id'}), 200);
        return response;
      });

      // Navigate to landing page
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Sign Up and sign up
      await tester.tap(find.byType(ElevatedButton).at(1));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'testuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'testpassword');
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      // Verify navigation to HomeScreen
      expect(find.text('Welcome to MindTwist!'), findsOneWidget);

      // Navigate to Profile
      await tester.tap(find.byType(ElevatedButton).at(1));
      await tester.pumpAndSettle();
      expect(find.text('Your profile information'), findsOneWidget);

      // Navigate to Update Profile
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();
      expect(find.text('Update your profile information here'), findsOneWidget);

      // Navigate to Admin
      await tester.tap(find.byType(ElevatedButton).at(2));
      await tester.pumpAndSettle();
      expect(find.text('Admin panel functionalities'), findsOneWidget);

      // Navigate to Teaser
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();
      expect(find.text('Choose a category to play'), findsOneWidget);

      // Navigate to Analytics
      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();
      expect(
          find.text('Your analytics will be displayed here'), findsOneWidget);

      // Sign Out
      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();
      expect(find.text('MIND-TWIST'), findsOneWidget);
    });
  });
}

// Mock shared preferences for testing.
class MockSharedPreferences extends Mock implements SharedPreferences {}

// The GoRouter instance used for routing.
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/frame',
      builder: (context, state) => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return const MainContainer();
          } else {
            return const LandingPage();
          }
        },
      ),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: 'teaser',
          builder: (context, state) => const TeaserScreen(),
        ),
        GoRoute(
          path: 'analytics',
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: 'update_profile',
          builder: (context, state) => const UpdateProfileScreen(),
        ),
        GoRoute(
          path: 'admin',
          builder: (context, state) => const AdminScreen(),
        ),
      ],
    ),
  ],
);
