import 'package:flutter/material.dart';
import 'package:reminderapplatest/widgets/bottomSheet_widget.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../services/ReminderClass.dart';

class CustomCard extends StatefulWidget {


  final reminderTitle;
  final reminderBody;
  Function onPressed;
  CustomCard({this.reminderTitle,this.reminderBody,this.onPressed});
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  TextEditingController reminderTitle = new TextEditingController();
  String reminderTime = 'choose time' ;
  String reminderDate=  'choose Date' ;

  ReminderClass _reminderClass = ReminderClass();
  BottomSheetWidget _bottomSheetWidget = BottomSheetWidget();


  void editReminder(reminderTitl,reminderBody) async{
    reminderTitle.text = reminderTitl.split('^')[1];
    print(reminderTitle.text);
    var split = reminderBody.split(' ');
    reminderDate = split[0];
    reminderTime = split[1];

    await  showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,

        builder: (context){
       //  return  _bottomSheetWidget.editReminderBottomSheet(context,widget.onPressed,reminderTitl,reminderDate,reminderTime);

        }).then((onValue){
      setState(() {

      });
    });


  }

  showAlertDialog(BuildContext context,reminderID) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed:  () {
        _reminderClass.cancelNotificationByID(int.parse(reminderID));
        Navigator.pop(context);
        widget.onPressed();

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var reminderID = widget.reminderTitle.split('^')[0];
    var reminderTitle = widget.reminderTitle.split('^')[1];
    var reminderDate = widget.reminderBody.split(' ')[0];
    var reminderTime = widget.reminderBody.split(' ')[1];

    var parsedDate = DateTime.parse(widget.reminderBody);

   var x = DateFormat("h:mma").format(parsedDate);


    return Container(
      margin: EdgeInsets.all(5),
      decoration: new BoxDecoration(
          color: silverColor,
          borderRadius: new BorderRadius.all(Radius.circular(25))
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.topLeft,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Text(reminderTitle),),
              SizedBox(height: 15,),
              Row(
                children: <Widget>[
      Text(reminderDate),
      Text(' , '),
                  Text(x),

                ],),
            ],
          ),
        ),

    DropdownButtonHideUnderline(
      child: Container(

child: PopupMenuButton(
  color: Colors.lightBlue,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  onSelected: (result) {


    if(result == 'Edit'){
      editReminder(widget.reminderTitle,widget.reminderBody);
              }else if (result == 'Delete'){
      showAlertDialog(context,reminderID);
              }

            },
  itemBuilder: (BuildContext context) =>[
    const PopupMenuItem(
      value: 'Delete',
      child: Text('Delete')
    ),
    const PopupMenuItem(
      value: 'Edit',
      child:  Text('Edit'),
    ),

  ],
),
//        child: Theme(
//
//          data: ThemeData(
//              canvasColor: Colors.red,
//              primaryColor: Colors.black,
//              accentColor: Colors.black,
//              hintColor: Colors.black,
//
//            popupMenuTheme: PopupMenuThemeData(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(15.0),
//              ),
//            )
//
//
//          ),
//          child: new DropdownButton<String>(
//
//            style: TextStyle(color: Colors.green),
//            icon: Icon(Icons.more_vert),
//            items: <String>['Edit', 'Delete',].map((String value) {
//
//              return new DropdownMenuItem<String>(
//
//
//                value: value,
//                child: new Text(value),
//              );
//            }).toList(),
//            onChanged: (value) {
//              if(value == 'Edit'){
//
//                editReminder(widget.reminderTitle,widget.reminderBody);
//
//              }else if (value == 'Delete'){
//                showAlertDialog(context,reminderID);
//              }
//
//            },
//          ),
//        ),
      ),
    ),
  ],
),


      ),
    );

  }


}
