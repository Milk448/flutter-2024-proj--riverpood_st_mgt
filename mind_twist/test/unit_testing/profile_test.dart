import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/welcome/signUp.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockHttpClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        Uri.parse('http://example.com')); // Register fallback for Uri
  });

  group('SignUpScreen', () {
    late SignUpScreen signUpScreen;
    late MockGoRouter mockGoRouter;
    late MockHttpClient mockHttpClient;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      signUpScreen = SignUpScreen();
      mockGoRouter = MockGoRouter();
      mockHttpClient = MockHttpClient();
      mockSharedPreferences = MockSharedPreferences();

      when(() => mockHttpClient.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response(
              jsonEncode({'token': 'test_token', 'userId': '1'}), 201));

      // Mock Shared Preferences
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // Mock GoRouter push
      when(() => mockGoRouter.go(any())).thenReturn(null);
    });

    testWidgets('renders title and form fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(path: '/', builder: (context, state) => signUpScreen),
            ],
          ),
        ),
      );

      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });
  });
}
