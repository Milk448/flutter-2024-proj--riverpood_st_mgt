import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/profile/update_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockHttpClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        Uri.parse('http://example.com')); // Register fallback for Uri
  });

  group('UpdateProfilePage', () {
    late UpdateProfilePage updateProfilePage;
    late MockGoRouter mockGoRouter;
    late MockHttpClient mockHttpClient;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      updateProfilePage = UpdateProfilePage();
      mockGoRouter = MockGoRouter();
      mockHttpClient = MockHttpClient();
      mockSharedPreferences = MockSharedPreferences();

      // Mock HTTP Client
      when(() =>
          mockHttpClient.put(any(),
              headers: any(named: 'headers'),
              body: any(named: 'body'))).thenAnswer((_) async =>
          http.Response('{"message": "Profile updated successfully"}', 200));

      // Mock Shared Preferences
      when(() => mockSharedPreferences.getString('token'))
          .thenReturn('test_token');
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
              GoRoute(
                  path: '/', builder: (context, state) => updateProfilePage),
            ],
          ),
        ),
      );

      expect(find.text('Update Profile'), findsOneWidget);
      expect(find.text('Enter new username'), findsOneWidget);
      expect(find.text('Enter new password'), findsOneWidget);
    });
  });
}
