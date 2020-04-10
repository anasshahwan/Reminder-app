import 'package:flutter/material.dart';
import 'package:reminderapplatest/screens/contact-us.dart';
import '../widgets/bottomSheet_widget.dart';
class DrawerWidget extends StatefulWidget {

  DrawerWidget({this.onPressed});
  Function onPressed;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  BottomSheetWidget _bottomSheetWidget = BottomSheetWidget();

  void _onBottomPressed() async{
    await  showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,

        builder: (context){

          return  _bottomSheetWidget.openBottomSheetToAddReminder(context);

        }).then((onValue){
          print(onValue);
          widget.onPressed();
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 70,
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.close),
              iconSize: 30,
              color: Colors.white,
              onPressed: (){
                Navigator.pop(context);

              },
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25)),
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Add A Reminder '),
            leading:new Tab(icon: new Image.asset("images/notification_add_icon.png",height: 20,),),

            onTap: () {

              Navigator.pop(context);
              _onBottomPressed();
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Tell a Friend'),
            leading:Icon(Icons.share),

            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Rate Us'),
            leading:Icon(Icons.star_half),

            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Contact Us '),
            leading:Icon(Icons.comment),

            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ContactUs.id);
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('About Us  '),
            leading:Icon(Icons.group),

            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
      ],
    );

  }
}
