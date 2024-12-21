import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mofa/colors/colorWillBe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  List<String> availableItems = []; // List to store available items

  // Replace with your valid API key
  static const apiKey = "AIzaSyBP84bR_Gsi3EnX6lf4nPTsmTlnSN4ykIU";

  // Correct API endpoint
  static const apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" +
          apiKey;

  @override
  void initState() {
    super.initState();
    _fetchStoredItems(); // Fetch stored items on initialization
  }

  Future<void> _fetchStoredItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      availableItems = prefs.getStringList('storedItems') ?? [];
    });
    print('Available items: $availableItems'); // Debugging
  }

  Future<String> callGenerativeAI(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "User has these items: $availableItems. User asks: $userInput"
                }
              ]
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'] ??
              "No response from AI.";
        } else {
          return "No valid response from AI.";
        }
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}\nResponse Body: ${response.body}";
      }
    } catch (e) {
      return "Error calling API: $e";
    }
  }

  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"text": userMessage, "isUser": true});
      _controller.clear();
    });

    final aiResponse = await callGenerativeAI(userMessage);

    setState(() {
      messages.add({"text": aiResponse, "isUser": false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MofaAI Chatbot'),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.w),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['isUser'] as bool;
                return _buildMessageBubble(message['text'], isUser);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        decoration: BoxDecoration(
          color: isUser ? Colorwillbe.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r).copyWith(
            topLeft: Radius.circular(isUser ? 10.r : 0),
            topRight: Radius.circular(isUser ? 0 : 10.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colorwillbe.secondaryColor : Colors.black,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Ask for a new recipe idea...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: Colorwillbe.primaryColor,
          ),
        ],
      ),
    );
  }
}
