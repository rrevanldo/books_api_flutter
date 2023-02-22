import 'package:flutter/material.dart';
import 'package:strapi_backend/view/show_books.dart';
import 'package:strapi_backend/view/books.dart';
import 'package:strapi_backend/view/editBooks.dart';
import 'package:http/http.dart' as http;
class MyDetails extends StatefulWidget {
 final  Books books;
  const MyDetails({this.books }) ;

  @override
  _MyDetailsState createState() => _MyDetailsState();
}
 
class _MyDetailsState extends State<MyDetails> {
  @override
  Widget build(BuildContext context) {
    void deleteUser()async{
      await http.delete(Uri.parse("https://sahabatpeduliyatim.com/public/api/delete/${widget.books.id}"));
       Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => DisplayBooks()),
          (Route<dynamic> route) => false);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Details'),
        elevation: 0.0,
        backgroundColor: Colors.indigo[700],
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 18,vertical:32),
          child: Column(
            children: [
              Container(
                height:50,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo[700],
                child: Center(child: Text('Details',style: TextStyle(color: Color(0xffFFFFFF)),)),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.books.id}'),
                      SizedBox(height: 10,),
                      Text(widget.books.title),
                      SizedBox(height: 10,),
                      Text(widget.books.description),
                      SizedBox(height: 10,),
                      Text(widget.books.created_at),
                      SizedBox(height: 10,),
                      Text(widget.books.updated_at),    
                    ],
                  ),
                ),
                // height: 455 ,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                   color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0,1),

                    ),
                  ]
                ),
                
              ),
              Row(
                children:[
                  TextButton(
                    onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>EditBooks(books: widget.books,)));
                     
                    }, child:Text('Edit'),
                  ),
                  TextButton(
                    onPressed:(){
                      deleteUser();

                    }, child:Text('Delete'),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}