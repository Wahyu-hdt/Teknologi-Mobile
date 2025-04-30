import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "Loading...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    final response = await http.get(url);
    await Future.delayed(Duration(seconds: 1));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        result = data['name'];
        isLoading = false;
      });
    } else {
      setState(() {
        result = "Failed to load data";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 8,
          backgroundColor: Colors.teal,
          title: Center(
            child: Text(
              "Flutter App Example",
              style: GoogleFonts.robotoSerif(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),

        body: Center(
          child:
              isLoading
                  ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 98, 110, 116),
                    ),
                    strokeWidth: 3,
                    backgroundColor: const Color.fromARGB(255, 245, 238, 221),
                  )
                  : Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(32),

                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
