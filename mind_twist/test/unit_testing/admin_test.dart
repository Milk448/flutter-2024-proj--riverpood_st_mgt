import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/admin/admin.dart';
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

  group('AdminPage', () {
    late AdminPage adminPage;
    late MockGoRouter mockGoRouter;
    late MockHttpClient mockHttpClient;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      adminPage = AdminPage();
      mockGoRouter = MockGoRouter();
      mockHttpClient = MockHttpClient();
      mockSharedPreferences = MockSharedPreferences();

      // Mock HTTP Client
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(
              jsonEncode([
                {'_id': '1', 'username': 'user1', 'role': 'user'},
                {'_id': '2', 'username': 'admin1', 'role': 'admin'}
              ]),
              200));

      // Mock Shared Preferences
      when(() => mockSharedPreferences.getString('token'))
          .thenReturn('test_token');

      // Mock GoRouter push
      when(() => mockGoRouter.push(any())).thenAnswer((_) async => null);
    });

    testWidgets('renders title and Create User button', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(path: '/', builder: (context, state) => adminPage),
            ],
          ),
        ),
      );

      expect(find.text('Admin Panel'), findsOneWidget);
      expect(find.text('Create User'), findsOneWidget);
    });
  });
}
