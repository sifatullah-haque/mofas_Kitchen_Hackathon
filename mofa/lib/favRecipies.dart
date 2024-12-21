import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mofa/colors/colorWillBe.dart';
import 'package:mofa/RecipeDetail.dart';

class FavRecipes extends StatelessWidget {
  FavRecipes({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> recipes = [
    {
      'title': 'Spaghetti Carbonara',
      'imageUrl': 'assets/2.png',
      'ingredients': [
        '200g spaghetti',
        '100g pancetta',
        '2 eggs',
        '50g grated Parmesan cheese',
        'Salt & pepper to taste'
      ],
      'instructions': [
        'Boil the spaghetti in salted water until al dente.',
        'Fry the pancetta in a pan until crispy.',
        'Whisk the eggs and grated cheese together in a bowl.',
        'Drain the spaghetti and mix with the fried pancetta.',
        'Off the heat, quickly stir in the egg and cheese mixture.',
        'Season with salt and pepper. Serve immediately.'
      ],
    },
    {
      'title': 'Chicken Curry',
      'imageUrl': 'assets/1.png',
      'ingredients': [
        '500g chicken breast',
        '1 onion, finely chopped',
        '2 cloves of garlic, minced',
        '1 tbsp curry powder',
        '400ml coconut milk',
        '2 tbsp oil',
        'Salt & pepper to taste'
      ],
      'instructions': [
        'Heat oil in a pan over medium-high heat.',
        'Add chopped onions and garlic, sauté until golden.',
        'Stir in curry powder and cook for 1 minute.',
        'Add chicken pieces, cook until sealed.',
        'Pour in coconut milk, bring to a simmer.',
        'Cover and cook for 15-20 minutes until chicken is done.',
        'Season with salt and pepper to taste.'
      ],
    },
    // Add more recipes here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fav Recipes'),
        titleTextStyle: TextStyle(
          color: Colorwillbe.secondaryColor,
          fontSize: 20.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 50.h,
        backgroundColor: Colorwillbe.primaryColor,
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.w),
              leading: CircleAvatar(
                radius: 25.w,
                backgroundColor: Colors.grey[200],
                backgroundImage: AssetImage(recipe['imageUrl']),
                onBackgroundImageError: (exception, stackTrace) {
                  // If the image fails to load, do nothing;
                  // the CircleAvatar will just show the backgroundColor
                },
                child: (recipe['imageUrl'] == null)
                    ? Icon(
                        Icons.restaurant_menu,
                        color: Colorwillbe.primaryColor,
                        size: 24.w,
                      )
                    : null,
              ),
              title: Text(
                recipe['title'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                '${recipe['ingredients'].length} ingredients',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(
                      title: recipe['title'],
                      imageUrl: recipe['imageUrl'],
                      ingredients: List<String>.from(recipe['ingredients']),
                      instructions: List<String>.from(recipe['instructions']),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
