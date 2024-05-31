import 'package:flutter/material.dart';
import 'package:mind_twist/presentation/screens/admin/admin.dart';
import 'package:mind_twist/presentation/screens/home/container.dart';
import 'package:mind_twist/presentation/screens/welcome/landing_page.dart';
import 'package:mind_twist/presentation/screens/home/home_screen.dart';
import 'package:mind_twist/presentation/screens/profile/profile.dart';
import 'package:mind_twist/presentation/screens/welcome/signIn.dart';
import 'package:mind_twist/presentation/screens/welcome/signUp.dart';
import 'package:mind_twist/presentation/screens/teaser/teaser_screen.dart';
import 'package:mind_twist/presentation/screens/profile/update_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_twist/presentation/widgets/score_display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_twist/presentation/screens/teaser/tease_screen.dart'; // Import TeaseScreen
// import 'package:mind_twist/core/domain/user/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/frame',
        builder: (context, state) => const MainContainer(),
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
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/home_screen',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/teaser',
        builder: (context, state) => const TeaserScreen(),
      ),
      GoRoute(
        path: '/update_profile',
        builder: (context, state) => const UpdateProfilePage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => FutureBuilder<StatefulWidget>(
          future: _buildAdminPage(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
      GoRoute(
        path: '/tease_screen',
        builder: (context, state) {
          final Map<String, dynamic>? data =
              state.extra as Map<String, dynamic>?;
          final categoryName = data?['categoryName'];
          final questions = data?['questions'] as List<Map<String, dynamic>>?;
          final currentQuestionIndex = data?['currentQuestionIndex'];
          return TeaseScreen(
            categoryName: categoryName ?? '',
            questions: questions ?? [],
            currentQuestionIndex: currentQuestionIndex ?? 0,
          );
        },
      ),
      GoRoute(
        path: '/score_screen',
        builder: (context, state) {
          final Map<String, dynamic>? data =
              state.extra as Map<String, dynamic>?;
          final score = data?['score'];
          final totalQuestions = data?['totalQuestions'];
          return ScoreScreen(
            score: score ?? 0,
            totalQuestions: totalQuestions ?? 0,
          );
        },
      ),
    ],
  );
});

Future<StatefulWidget> _buildAdminPage(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userRole = prefs.getString('userRole');
  if (userRole == 'admin') {
    return const AdminPage();
  } else {
    return const HomeScreen();
  }
}
