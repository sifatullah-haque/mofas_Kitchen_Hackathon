import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mofa/colors/colorWillBe.dart';

class Addingradiants extends StatefulWidget {
  const Addingradiants({super.key});

  @override
  _AddingradiantsState createState() => _AddingradiantsState();
}

class _AddingradiantsState extends State<Addingradiants> {
  String? selectedItemType;
  String? selectedItem;
  TextEditingController quantityController = TextEditingController();

  final List<String> itemTypes = [
    'Spices, Herbs & Seasonings',
    'Fruits',
    'Vegetables',
    'Meats & Poultry',
    'Dairy & Eggs'
  ];

  final Map<String, List<String>> items = {
    'Spices, Herbs & Seasonings': ['Salt', 'Pepper', 'Cumin', 'Chili Powder'],
    'Fruits': ['Apple', 'Banana', 'Orange', 'Mango'],
    'Vegetables': ['Carrot', 'Broccoli', 'Tomato', 'Spinach'],
    'Meats & Poultry': ['Chicken', 'Beef', 'Pork', 'Turkey'],
    'Dairy & Eggs': ['Milk', 'Butter', 'Eggs', 'Cheese']
  };

  // Function to save item to shared preferences
  Future<void> saveItemToLocalStorage(String item, String quantity) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? storedItems = prefs.getStringList('storedItems') ?? [];

      // Find if item already exists
      bool itemExists = false;
      for (int i = 0; i < storedItems.length; i++) {
        if (storedItems[i].startsWith('$item - ')) {
          int currentQuantity = int.parse(storedItems[i].split(' - ')[1]);
          int newQuantity = currentQuantity + int.parse(quantity);
          storedItems[i] = '$item - $newQuantity';
          itemExists = true;
          break;
        }
      }

      // If item does not exist, add it
      if (!itemExists) {
        storedItems.add('$item - $quantity');
      }

      // Save the updated list back to SharedPreferences
      await prefs.setStringList('storedItems', storedItems);

      print('Final stored items: ${prefs.getStringList('storedItems')}');
    } catch (e) {
      print("Error saving item to SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: Column(
          children: [
            // Select Item Type Dropdown
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colorwillbe.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedItemType,
                      hint: Text(
                        'Select Item Type',
                        style: TextStyle(
                          color: Colorwillbe.secondaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedItemType = value;
                          selectedItem = null; // Reset item when type changes
                        });
                      },
                      items: itemTypes.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colorwillbe.textColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Conditionally show the Select Item Dropdown if an Item Type is selected
            if (selectedItemType != null)
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colorwillbe.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      DropdownButton<String>(
                        value: selectedItem,
                        hint: Text(
                          'Select Item',
                          style: TextStyle(
                            color: Colorwillbe.secondaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        items: items[selectedItemType]!
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colorwillbe.textColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20.h),

            // Conditionally show the Quantity TextField if an Item is selected
            if (selectedItem != null)
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colorwillbe.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Quantity. e.g. 3',
                            hintStyle: TextStyle(
                              color: Colorwillbe.secondaryColor,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colorwillbe.textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 50.h),

            // Button to add item and save it to local storage
            GestureDetector(
              onTap: () {
                if (selectedItem != null &&
                    quantityController.text.isNotEmpty) {
                  saveItemToLocalStorage(
                      selectedItem!, quantityController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Item added successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select an item and enter quantity.'),
                  ));
                }
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'Add Item',
                    style: TextStyle(
                      color: Colorwillbe.secondaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
