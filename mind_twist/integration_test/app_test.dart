import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mind_twist/main.dart' as app;
import 'package:mind_twist/presentation/screens/welcome/landing_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Mind Twist Integration Tests', () {
    testWidgets('App Loads Successfully', (WidgetTester tester) async {
      // Load the app
      app.main();

      // Verify that the landing page is displayed
      await tester.pumpAndSettle();
      expect(find.byType(LandingPage), findsOneWidget);
    });
  });
}
