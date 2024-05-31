import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('HomeScreen', () {
    late HomeScreen homeScreen;
    late MockGoRouter mockGoRouter;

    setUp(() {
      homeScreen = HomeScreen();
      mockGoRouter = MockGoRouter();
      // Ensure the mock 'push' method is called when expected
      when(() => mockGoRouter.push(any())).thenAnswer((_) async => null);
    });

    testWidgets('renders title and Daily Twist button', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(path: '/', builder: (context, state) => homeScreen),
            ],
          ),
        ),
      );

      expect(find.text('Welcome to Brain Teaser'), findsOneWidget);
      expect(find.text('Daily Twist'), findsOneWidget);
    });
  });
}
