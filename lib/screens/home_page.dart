import 'package:flutter/material.dart';
import 'constants.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onBottomPressed(){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        builder: (context){
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text("Add a Reminder"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(child: Text("Title")),
        Container(
          width: 240,
          child: TextField(
            decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Subject'
          ),),
        ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                Text("Choose A Date"),
                Container(
                  height: 25.0,
                  width: 1.0,
                  color: Colors.black,
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                Text("Choose Time"),


              ],),
              RaisedButton(
child: Text("Add  "),
                onPressed: (){
                print("addedd");
                Navigator.pop(context);
//                var count = 0;
//                Navigator.popUntil(context, (route) {
//                  return count++ == 1;
//                });
                // Navigator.pop(context);


              },)
          ],),
        ),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0.0,
  leading: Builder(
    builder: (BuildContext context) {
      return  GestureDetector(
        onTap: (){
          Scaffold.of(context).openDrawer();
        },

        child: Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.topLeft,
          child: new Tab(icon: new Image.asset("images/menu-icon.png",height: 20)),


        ),
      );

    },
  ),


),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
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
        ),
      )
      ,

        floatingActionButton: FloatingActionButton(
          onPressed: () {

            print("Open Bottom sheet ");
            _onBottomPressed();

          },
          child: new Tab(icon: new Image.asset("images/notification_add_icon.png")),
          backgroundColor: Colors.white,
        ),
        body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10),

              child: Text("Up Coming Reminders",style: headerTextStyle,)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[


                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
                CustomCard(),
              ],
            ),

          )
        ],
      ),),
    );
  }
}


class CustomCard extends StatefulWidget {
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
          color: silverColor,
          borderRadius: new BorderRadius.all(Radius.circular(25))
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Text('Reminder Title ',style: reminderTitleTextStyle,)),
            Align(
                alignment: Alignment.topLeft,
                child: Text('3/12/2020 , 10:20 PM',style: reminderDateTimeTextStyle,)),

          ],
        ),
      ),
    );

  }

}

