import 'package:flutter/material.dart';
import 'package:reminderapplatest/widgets/bottomSheet_widget.dart';
import 'package:reminderapplatest/widgets/drawer_widget.dart';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:sortedmap/sortedmap.dart';
import '../widgets/reminder_card.dart';
import '../services/ReminderClass.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ReminderClass _reminderClass = ReminderClass();
  BottomSheetWidget _bottomSheetWidget = BottomSheetWidget();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reminderClass.initializeNotifications();

  }

  void _openBottomSheet() async{

   await  showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        builder: (context){
   return  _bottomSheetWidget.openBottomSheetToAddReminder(context);

    }).then((onValue){ setState(() {}); });
  }



  sortTheDataByDate(remindersData){

    var map = new SortedMap(Ordering.byValue());
    for ( var x in remindersData){
      var idAndTitle = x.id.toString() +'^'+ x.title;
      map.addAll({
        idAndTitle: x.body,
      });
    }
    dynamic ls = map.values.toList();
    dynamic mp = map.keys.toList();

    return [ls,mp];
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
    //  top: false,
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
      drawer:Drawer(child: DrawerWidget(onPressed: (){
        setState(() {});
      },))
      ,

        floatingActionButton: FloatingActionButton(
          onPressed: _openBottomSheet,
          child: new Tab(icon: new Image.asset("images/notification_add_icon.png")),
          backgroundColor: Colors.white,
        ),
        body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10),

              child: Text("Up Coming Reminders",style: headerTextStyle,)),
          SizedBox(height: 15,),
          Expanded(
            child: FutureBuilder(
              future: _reminderClass.chekPendingNotificationRequests(), // a Future<String> or null
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none: return new Text('Press button to start');
                  case ConnectionState.waiting: return new CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                    {
                      var dataLength = snapshot.data.length;
                      if(dataLength == 0){
                        return Center(child: Center(
                          child: GestureDetector(
                            onTap: (){
                              _openBottomSheet();
                            },
                            child: Wrap(
                              direction: Axis.horizontal,
                       crossAxisAlignment: WrapCrossAlignment.center,
                       //   mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("No Reminders for this day, tap on ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                Image.asset("images/notification_add_icon.png",height: 30),
                                Text('to add new one.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              ],
                            ),
                          ),
                        ));
                      }else {

                       var sortedReminders =  sortTheDataByDate(snapshot.data,);
                       var sortedDates = sortedReminders[0];
                       var sortedTitles = sortedReminders[1];
                       print(sortedReminders);

                        return  ListView.builder(
                          itemCount: sortedDates.length,
                          itemBuilder: (context, index) {

                            return Column(
                              children: <Widget>[

                                CustomCard(reminderTitle: sortedTitles[index],reminderBody: sortedDates[index],onPressed:(){
                                  setState(() {

                                  });
                                }),
                                SizedBox(height: 10,)
                                //     Text(snapshot.data[index])
                              ],
                            );

                          },
                        );


                      }



                    }
                }
              },
            )
          )
        ],
      ),),
    );
  }
}







