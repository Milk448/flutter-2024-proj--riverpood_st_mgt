import 'package:flutter/material.dart';

class CategoryOption extends StatelessWidget {
  final String categoryName;
  final VoidCallback onTap;

  const CategoryOption(
      {super.key, required this.categoryName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 120, 113, 170),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
