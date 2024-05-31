import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          context.go('/home_screen');
          break;
        case 1:
          context.go('/teaser');
          break;
        case 2:
          break;
        case 3:
          context.go('/profile');
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 120, 113, 170),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Let us see how you are doing',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Refresh Statistics',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatItem('Teasers Taken:', '5'),
                          _buildStatItem('Questions Answered:', '50'),
                          _buildStatItem('Questions Missed:', '10'),
                          const SizedBox(height: 20),
                          const Divider(height: 20, color: Colors.grey),
                          const SizedBox(height: 20),
                          _buildStatItem('Total Time Taken:', '2h 30m'),
                          _buildStatItem(
                              'Average Time per Question:', '3m 15s'),
                          _buildStatItem('Fastest Completion Time:', '1h 20m'),
                          _buildStatItem('Slowest Completion Time:', '3h 10m'),
                          const SizedBox(height: 20),
                          const Divider(height: 20, color: Colors.grey),
                          const SizedBox(height: 20),
                          const Text(
                            'Additional Stats:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          _buildStatItem('Accuracy Percentage:', '85%'),
                          _buildStatItem('Average Score:', '75'),
                          _buildStatItem('Highest Score:', '90'),
                          _buildStatItem('Lowest Score:', '60'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
