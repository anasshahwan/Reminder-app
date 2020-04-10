import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../services/ReminderClass.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { lafayette, jefferson }

SingingCharacter _character = SingingCharacter.lafayette;

class BottomSheetWidget {
  TextEditingController reminderTitle = new TextEditingController();
  ReminderClass _reminderClass = ReminderClass();

  //String reminderTime = DateFormat.jm().format(DateTime.now()).toString()
  String reminderTime = 'Select Time';
  //String reminderDate = DateTime.now().toString().split(' ')[0];
  String reminderDate = 'Select Date';

  bool isSwitched = false;


  final _formKey = GlobalKey<FormState>();

  convertUserTimeToDateTime(getUserDate, getUserTime) {
    var getUserDateSplit = getUserDate.split('-');
    var getUserTimeSplit = getUserTime.split(':');
    //  var parsedDate = DateTime.parse('2020-04-09 23:09:00.000');

    //var x =  DateFormat("h:mma").format(parsedDate);

    var year = int.parse(getUserDateSplit[0]);
    var month = int.parse(getUserDateSplit[1]);
    var day = int.parse(getUserDateSplit[2]);

    print(getUserTimeSplit[0]);
    print(getUserTimeSplit[1]);
    // print(x);

    var hour = int.parse(getUserTimeSplit[0]);
    var minutes = int.parse(getUserTimeSplit[1]);
    var seconds = int.parse(getUserTimeSplit[2]);

    // Convert The User Date And Time To DateTime DataType to be able to make a comparison
    var userDateAndTime = DateTime(year, month, day, hour, minutes, seconds);

    return userDateAndTime;
  }

  var remindTitle;
  var scheduledNotificationDateTime;

  var timeNow = DateFormat.jm().format(DateTime.now());
  var isTimeValid = false;

  List<String> options = <String>['One', 'Two', 'Free', 'Four'];
  String dropdownValue = 'One';

  bool validationBottomSheet() {
    if (reminderDate == 'Select Date' ||
        reminderTime == 'Select Time' ||
        reminderTitle.text == '') {
      // print('Plesae ');
      isTimeValid = false;
      return false;
    } else {
      isTimeValid = true;
      return true;
    }

//    print(timeNow);
//    print(reminderTime);
//
//    if (_formKey.currentState.validate()) {
//      if (timeNow == reminderTime) {
//        print('choose correct Time');
//
//         // isTimeValid = false;
//
//      } else {
//     //   isTimeValid = true;
//        remindTitle = reminderTitle.text;
//

//        if (DateTime.now().compareTo(scheduledNotificationDateTime) <= 0) {
//          return true;
//        } else {
//          return false;
//        }
//      } // else
//
//    }
//
  }

  double _result = 0.0;

  var _radioValue = 0;

  openBottomSheetToAddReminder(context) {
    void _handleRadioValueChange(int value) {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          print(0);
          break;
        case 1:
          print(1);
          break;
        case 2:
          print(2);
          break;
      }
    }

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        validationBottomSheet();

        return Container(
          height: 300,
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
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          onChanged: (text) {
                            if (text == '') {
                              print('empty Text');
                              isTimeValid = false;
                              setState(() {});
                            } else {
                              if (timeNow == reminderTime ||
                                  timeNow.compareTo(reminderTime) >= 0) {
                                print('fix the Time');
                              } else {
                                print(text);
                                isTimeValid = true;
                                setState(() {});
                              }
                            }

                            ///  Text Validation Done ..

//                           if(text == '' || timeNow == reminderTime){
//                             setState((){
//
//isTimeValid = false;
//                             });
//                             print('null');
//
//                           }else if (timeNow != reminderTime){
//                             setState((){
//                               isTimeValid = true;
//
//                             });
//                           }
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              isTimeValid = false;
                              return 'Please enter some text';
                            } else {
                              isTimeValid = true;
                              return null;
                            }
                          },
                          controller: reminderTitle,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: 'Remind me To '),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2024, 12, 30),
                            onChanged: (date) {}, onConfirm: (date) {
                          // To update The Ui Date
                          setState(() {
                            reminderDate = date.toString().split(' ')[0];
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text(
                        reminderDate,
                        style: TextStyle(color: Colors.blue),
                      )),
                  Container(
                    height: 25.0,
                    width: 1.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  FlatButton(
                      onPressed: () {
                        DatePicker.showTime12hPicker(context,
                            showTitleActions: true,
                            theme: DatePickerTheme(
                                headerColor: Colors.orange,
                                backgroundColor: Colors.blue,
                                itemStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)), onConfirm: (time) {
                          // Update The Ui Time State
                          setState(() {
                            reminderTime = DateFormat("h:mma").format(time);
                          });

                          if (timeNow.compareTo(reminderTime) <= 0 ||
                              timeNow == reminderTime) {
                            print('choose correct Time');
                            isTimeValid = true;
                          } else {
                            isTimeValid = false;
                          }
                        }, currentTime: DateTime.now());
                      },
                      child: Text(
                        reminderTime,
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              Text('How Many Times you want to be reminded '),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('1'),
                      Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('2'),
                      Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('3'),
                      Radio(
                        value: 3,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('4'),
                      Radio(
                        value: 4,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('5'),
                      Radio(
                        value: 5,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ],
                  ),
                ],
              ),

              Row(children: <Widget>[
                Text('Save it For History'),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],),
              RaisedButton(
                child: Image.asset(
                  'images/notification_add_icon.png',
                  height: 20,
                ),
                onPressed: isTimeValid == false
                    ? null
                    : () async {
                        bool isValid = validationBottomSheet();

                        if (isValid == true && isTimeValid == true) {
                          var df = DateFormat("h:mma");
                          var dt = df.parse(reminderTime.toString());
                          reminderTime = DateFormat('HH:mm:ss').format(dt);
                          print(reminderTime);
                          scheduledNotificationDateTime =
                              convertUserTimeToDateTime(
                                  reminderDate, reminderTime);
                          remindTitle = reminderTitle.text;
                          _reminderClass.scheduleNoti(
                              remindTitle, scheduledNotificationDateTime);

                          Navigator.pop(context);
                          setState(() {});
                          reminderTitle.clear();
                          isTimeValid = false;
                        } else {
                          print('Please Choose Write Data');
                        }
                      },
              ),
            ],
          ),
        );
      }),
    );
  }

//
//  editReminderBottomSheet(
//      context, onPressed, reminderTitl, reminderDate, reminderTime) {
//    reminderTitle.text = reminderTitl.split('^')[1];
//
//    return Padding(
//      padding:
//          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//      child: StatefulBuilder(builder: (BuildContext context,
//          StateSetter setState /*You can rename this!*/) {
//        return Container(
//          height: 300,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text("Add a Reminder"),
//              Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: Row(
//                  children: <Widget>[
//                    Container(child: Text("Title")),
//                    Container(
//                      width: 240,
//                      child: TextField(
//                        controller: reminderTitle,
//                        decoration: new InputDecoration(
//                            border: InputBorder.none,
//                            focusedBorder: InputBorder.none,
//                            contentPadding: EdgeInsets.only(
//                                left: 15, bottom: 11, top: 11, right: 15),
//                            hintText: 'Subject'),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  FlatButton(
//                      onPressed: () {
//                        DatePicker.showDatePicker(context,
//                            showTitleActions: true,
//                            minTime: DateTime.now(),
//                            maxTime: DateTime(2024, 12, 30), onChanged: (date) {
//                          print('change $date');
//                        }, onConfirm: (date) {
//                          //     print('confirm $date');
//                          setState(() {
//                            reminderDate = date.toString().split(' ')[0];
//                          });
//                        }, currentTime: DateTime.now(), locale: LocaleType.en);
//                      },
//                      child: Text(
//                        reminderDate,
//                        style: TextStyle(color: Colors.blue),
//                      )),
//                  Container(
//                    height: 25.0,
//                    width: 1.0,
//                    color: Colors.black,
//                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                  ),
//                  FlatButton(
//                      onPressed: () {
//                        DatePicker.showTime12hPicker(context,
//                            showTitleActions: true,
//                            theme: DatePickerTheme(
//                                headerColor: Colors.orange,
//                                backgroundColor: Colors.blue,
//                                itemStyle: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 18),
//                                doneStyle: TextStyle(
//                                    color: Colors.white,
//                                    fontSize: 16)), onChanged: (time) {
//
////                            print('change $time in time zone ' +
////                                time.timeZoneOffset.inHours.toString());
//                        }, onConfirm: (time) {
//                          var realtime = time.toString().split(' ');
//                          print(realtime[1]);
//                          var xyz = realtime[1];
//                          var reminder = xyz.split('.');
//                          reminderTime = reminder[0];
//
//                          setState(() {});
//                        }, currentTime: DateTime.now());
//                      },
//                      child: Text(
//                        reminderTime,
//                        style: TextStyle(color: Colors.blue),
//                      )),
//                ],
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  RaisedButton(
//                    child: Text("Edit "),
//                    onPressed: () async {
//                      print("Schedule ..");
//
//                      if (true) {
//                        var reminderID = int.parse(reminderTitl.split('^')[0]);
//                        _reminderClass.scheduleNotification(reminderDate,
//                            reminderTime, reminderTitle, reminderID);
//
//                        Navigator.pop(context);
//
//                        // To Update The State After The Edit
//                        onPressed();
//                      }
//                    },
//                  ),
//                ],
//              ),
//            ],
//          ),
//        );
//      }),
//    );
//  }
//
//

}
