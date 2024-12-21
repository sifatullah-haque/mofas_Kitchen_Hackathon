import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mofa/addIngradiants.dart';
import 'package:mofa/chatBot.dart';
import 'package:mofa/colors/colorWillBe.dart';
import 'package:mofa/favRecipies.dart';
import 'package:mofa/viewIngradiants.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Back Mofa!'),
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
              //a container with a text
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Viewingradiants(),
                            ));
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colorwillbe.primaryColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'View Ingredients',
                            style: TextStyle(
                              color: Colorwillbe.secondaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Addingradiants()));
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colorwillbe.primaryColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Add Ingredients',
                            style: TextStyle(
                              color: Colorwillbe.secondaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavRecipes()));
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colorwillbe.primaryColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Favorite Recipes',
                            style: TextStyle(
                              color: Colorwillbe.secondaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chatbot()));
                      },
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            'Chat With MofaAI',
                            style: TextStyle(
                              color: Colorwillbe.secondaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
