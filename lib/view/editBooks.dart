import 'package:flutter/material.dart';
import 'package:strapi_backend/customisation/textfield.dart';
import 'package:strapi_backend/view/show_books.dart';
import 'package:strapi_backend/view/books.dart';
import 'package:http/http.dart' as http;

class EditBooks extends StatefulWidget {
  final Books books;
  const EditBooks({Key key, this.books});

  @override
  _Editbookstate createState() => _Editbookstate();
}

class _Editbookstate extends State<EditBooks> {
  void editUser(
      {Books books, String title, String description, String created_at, String updated_at}) async {
    final response = await http.put(
        Uri.parse(
          "https://sahabatpeduliyatim.com/public/api/update/${books.id}",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json;charset=UTF-8',
        },
        body: <String, String>{
          'title': title,
          'description': description,
          'created_at': created_at,
          'updated_at': updated_at,
        });
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => DisplayBooks()),
          (Route<dynamic> route) => false);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.books.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.books.description);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: Text('Edit Data Books'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100, bottom: 100, left: 18, right: 18),
          child: Container(
            height: 550,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.indigo[700],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300,
                    decoration: BoxDecoration(boxShadow: [
                      
                    ]),
                    child: Textfield(
                      controller: titleController,
                      onChanged: (val) {
                        titleController.text = val;
                      },
                      hintText: 'Title',
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 300,
                    decoration: BoxDecoration(boxShadow: []),
                    child: Textfield(
                      controller: descriptionController,
                      onChanged: (val) {
                        descriptionController.text = val;
                      },
                      hintText: 'Email',
                    )),
                // Container(
                //     width: 300,
                //     decoration: BoxDecoration(boxShadow: []),
                //     child: Textfield(
                //       hintText: 'Password',
                //       onChanged: (val) {
                //         passwordController.text = val;
                //       },
                //       controller: passwordController,
                //     )),
                SizedBox(
                  width: 100,
                  child: TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        editUser(
                            books: widget.books,
                            title: titleController.text,
                            description: descriptionController.text);
                      },
                      child: Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
