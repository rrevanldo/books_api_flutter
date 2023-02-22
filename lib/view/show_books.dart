import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_backend/view/books.dart';
import 'package:strapi_backend/view/booksDetail.dart';
import 'package:strapi_backend/view/add_books.dart';

class DisplayBooks extends StatefulWidget {
  const DisplayBooks({Key key}) : super(key: key);

  @override
  _DisplayBooksState createState() => _DisplayBooksState();
}

class _DisplayBooksState extends State<DisplayBooks> {
  List<Books> books = [];
  Future<List<Books>> getAll() async {
    var response = await http.get(Uri.parse("https://sahabatpeduliyatim.com/public/api/books"));

    if (response.statusCode == 200) {
      books.clear();
    }
    var decodedData = jsonDecode(response.body);

    for (var u in decodedData) {
      books.add(Books(u['id'], u['title'], u['description'], u['created_at'],
          u['updated_at']));
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
        appBar: AppBar(
          title: Text('List Books'),
          elevation: 0.0,
          backgroundColor: Colors.indigo[700],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CreateBook();
                  }),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: getAll(),
            builder: (context, AsyncSnapshot<List<Books>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  // itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) => InkWell(
                        child: ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].description),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyDetails(
                                          books: snapshot.data[index],
                                        )));
                          },
                        ),
                      ));
            }));
  }
}
