
import 'package:flutter/material.dart';
import 'package:reminderapplatest/constants.dart';

class ContactUs extends StatefulWidget {

  static final id = '/contact-us';
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  Text('Contact Us',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              color: Colors.black
          ),

        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child:Text('We are always  Happy To Hear From You',style: reminderDateTimeTextStyle.copyWith(color: Colors.white),)),
            Card(
              margin: EdgeInsets.all(30),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
                  ),
                )
            ),

            RaisedButton(
              child: Text("Send Your FeedBack"),
              onPressed: () async{



            },) ,
            Text("You can also check the FAQ  "),
          ],
        ));
  }
}
