import 'package:flutter/material.dart';
import 'package:strapi_backend/view/show_books.dart';

void main() {
  runApp(Strapi());
}

class Strapi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:DisplayBooks()
    );
  }
}

