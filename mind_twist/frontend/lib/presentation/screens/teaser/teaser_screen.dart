import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mind_twist/presentation/screens/teaser/tease_screen.dart';
import 'package:mind_twist/presentation/widgets/category_options.dart';

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
        final List<dynamic> teaserData = json.decode(response.body);

        // Assuming we have 5 more categories
        setState(() {
          categoryQuestions = {
            'General Knowledge': teaserData
                .where((teaser) => teaser['category'] == 'General Knowledge')
                .map((teaser) => teaser as Map<String, dynamic>)
                .toList(),
            'Science': teaserData
                .where((teaser) => teaser['category'] == 'Science')
                .map((teaser) => teaser as Map<String, dynamic>)
                .toList(),
            'History': teaserData
                .where((teaser) => teaser['category'] == 'History')
                .map((teaser) => teaser as Map<String, dynamic>)
                .toList(),
            'Sports': teaserData
                .where((teaser) => teaser['category'] == 'Sports')
                .map((teaser) => teaser as Map<String, dynamic>)
                .toList(),
            'Entertainment': teaserData
                .where((teaser) => teaser['category'] == 'Entertainment')
                .map((teaser) => teaser as Map<String, dynamic>)
                .toList(),
            'Geography': teaserData
                .where((teaser) => teaser['category'] == 'Geography')
                .map((teaser) => teaser as Map<String, dynamic>)
                .toList(),
          };
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeaseScreen(
                      categoryName: categoryName,
                      questions: categoryQuestions[
                          categoryName]!, // Passing the list of maps directly
                      currentQuestionIndex: 0,
                    ),
                  ),
                );
                print('Tapped on $categoryName');
              },
            );
          },
        ),
      ),
    );
  }
}
