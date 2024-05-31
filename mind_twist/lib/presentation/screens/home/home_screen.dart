import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> categories = [
    "General Knowledge",
    "Science",
    "History",
    "Sports",
    "Entertainment",
    "Geography",
  ];

  Map<String, List<Map<String, dynamic>>> categoryQuestions = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          break;
        case 1:
          context.go('/teaser');
          break;
        case 2:
          context.go('/analytics');
          break;
        case 3:
          context.go('/profile');
          break;
        default:
      }
    });
  }

  Future<void> _fetchTeasers() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.42.1:3000/api/teasers'));
      if (response.statusCode == 200) {
        final List<dynamic> teaserData = jsonDecode(response.body);

        // Group teasers by category
        setState(() {
          categoryQuestions = teaserData.fold({}, (previousValue, element) {
            final category = element['category'];
            previousValue[category] = previousValue[category] ?? [];
            previousValue[category]!.add(element);
            return previousValue;
          });
        });
      } else {
        print('Failed to load teasers');
      }
    } catch (error) {
      print('Error fetching teasers: $error');
    }
  }

  Future<void> _navigateToRandomTeaser() async {
    // Fetch teasers if not already fetched
    if (categoryQuestions.isEmpty) {
      await _fetchTeasers();
    }

    // Choose a random category
    final random = Random();
    final randomCategoryIndex = random.nextInt(categories.length);
    final selectedCategory = categories[randomCategoryIndex];

    // Navigate to the TeaseScreen with the selected category
    context.push('/tease_screen', extra: {
      'categoryName': selectedCategory,
      'questions': categoryQuestions[selectedCategory]!,
      'currentQuestionIndex': 0,
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTeasers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your Scaffold contents here...
      backgroundColor: const Color.fromARGB(255, 120, 113, 170),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Brain Teaser',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToRandomTeaser,
              child: const Text(
                'Daily Twist',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Unleash Your Mind Every Day!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
