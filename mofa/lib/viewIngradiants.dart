import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mofa/colors/colorWillBe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Viewingradiants extends StatelessWidget {
  const Viewingradiants({super.key});

  // Function to get the stored items from shared preferences
  Future<List<String>> getStoredItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedItems = prefs.getStringList('storedItems');

    // Debug: Print storedItems to debug
    print('Retrieved items: $storedItems');

    return storedItems ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Ingredients'),
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
      body: FutureBuilder<List<String>>(
        future: getStoredItems(), // Fetch stored items
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items added yet.'));
          }
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              // Debug statement
              print('Rendering item: ${items[index]}');

              return ListTile(
                title: Text(items[index]),
              );
            },
          );
        },
      ),
    );
  }
}
