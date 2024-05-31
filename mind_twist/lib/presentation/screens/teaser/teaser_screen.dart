// mind_twist/lib/presentation/screens/teaser/teaser_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mind_twist/presentation/screens/teaser/tease_screen.dart';
import 'package:mind_twist/presentation/widgets/category_options.dart';
import 'package:go_router/go_router.dart';

class TeaserScreen extends StatefulWidget {
  const TeaserScreen({Key? key}) : super(key: key);

  @override
  _TeaserScreenState createState() => _TeaserScreenState();
}

class _TeaserScreenState extends State<TeaserScreen> {
  Map<String, List<Map<String, dynamic>>> categoryQuestions = {};

  @override
  void initState() {
    super.initState();
    _fetchTeasers();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 162, 155, 204),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 158, 152, 199),
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1,
          ),
          itemCount: categoryQuestions.keys.length,
          itemBuilder: (context, index) {
            String categoryName = categoryQuestions.keys.elementAt(index);
            return CategoryOption(
              categoryName: categoryName,
              onTap: () {
                context.push('/tease_screen', extra: {
                  'categoryName': categoryName,
                  'questions': categoryQuestions[categoryName]!,
                  'currentQuestionIndex': 0,
                });
                print('Tapped on $categoryName');
              },
            );
          },
        ),
      ),
    );
  }
}
