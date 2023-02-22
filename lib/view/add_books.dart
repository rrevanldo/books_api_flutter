import 'package:flutter/material.dart';
import 'package:strapi_backend/customisation/textfield.dart';
import 'package:strapi_backend/view/show_books.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_backend/view/books.dart';

class CreateBook extends StatefulWidget {
  final int id;
  const CreateBook({ Key key,this.id });

  @override
  _CreateBookState createState() => _CreateBookState();
}
 TextEditingController titleController = TextEditingController(text: books.title);
  TextEditingController descriptionController = TextEditingController(text: books.description);

  Books books = Books(0, '', '', '', '');

class _CreateBookState extends State<CreateBook> {
  Future save() async {
    // var jsonResponse = null;
     await http.post(Uri.parse("https://sahabatpeduliyatim.com/public/api/create",),
     headers:<String, String> {
      'Context-Type': 'application/json; charset=UTF-8',
    },body: <String,String> {  'title':books.title,
      'description': books.description,
      }
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => DisplayBooks()), (Route<dynamic> route) => false);
      }
  
   
  @override
  Widget build(BuildContext context) {
    //  print(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: Text('Create Book'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: 100,bottom: 100,left: 18,right: 18),
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
                   controller:titleController ,
                   onChanged: (val){
                     books.title = val;
                   },
                   hintText: 'Title',
                 )
                 ),
                 SizedBox(height: 10,),
                 Container(
                     width: 300,
                 decoration: BoxDecoration(boxShadow: [
                        ]),
                 child: Textfield(
                   controller: descriptionController,
                   onChanged: (val){
                     books.description = val;
                   },
                   hintText: 'Description',
                 )
                 ),
                //    Container(
                //      width: 300,
                //  decoration: BoxDecoration(boxShadow: [
                //         ]),
                //  child: Textfield(
                //    hintText: 'Password',
                //    onChanged: (val){
                //      books.password = val;
                //    },
                //    controller: passwordController,
                //  )
                //  ),
                 SizedBox(
                   width: 100,
                   child: TextButton(
                     style: TextButton.styleFrom(backgroundColor: Colors.white),
                     onPressed:save, child: Text('Save')),
                 )
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  
}

 