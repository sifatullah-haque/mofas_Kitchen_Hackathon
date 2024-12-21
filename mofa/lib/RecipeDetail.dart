import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;

  const RecipeDetail({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                // If there's an error loading the image, use a placeholder
                return Container(
                  color: Colors.grey[300],
                  height: 200,
                  child: const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                );
              },
            ),

            // Ingredients Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ingredients',
              ),
            ),
            ...ingredients.map((ingredient) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 20, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(ingredient),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Instructions Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Instructions',
              ),
            ),
            ...instructions.asMap().entries.map((entry) {
              int stepNumber = entry.key + 1;
              String stepText = entry.value;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '$stepNumber. $stepText',
                  style: const TextStyle(height: 1.5),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
