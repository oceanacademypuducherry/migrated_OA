import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class DesktopUserNotification extends StatefulWidget {
  @override
  _DesktopUserNotificationState createState() =>
      _DesktopUserNotificationState();
}

class _DesktopUserNotificationState extends State<DesktopUserNotification> {
  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int x = (prefs.getInt('login') ?? 0);
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSession();
  }

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(),
              width: 213,
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Go back',
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.blue,
                      size: 50,
                    ),
                    color: Colors.blue,
                    iconSize: 50,
                    splashRadius: 30,
                    onPressed: () {
                      setState(() {
                        // ignore: unnecessary_statements
                        // ContentWidget.isVisible != ContentWidget.isVisible;
                      });
                      Get.back();

                      ///todo Navigation

                      // Provider.of<Routing>(context, listen: false)
                      //     .updateRouting(widget: CoursesView());
                    },
                  ),
                  Text(
                    'Notification',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('new users')

                              ///LogIn.registerNumber
                              .doc(LoginResponsive.registerNumber)
                              .collection("specificnotification")
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data.docs;
                              List<NotifyDB> notifyData = [];

                              for (var message in messages) {
                                final messageDescription =
                                    message['description'];
                                final sampleNotify = NotifyDB(
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');

                                notifyData.add(sampleNotify);
                              }
                              return Column(
                                children: notifyData,
                              );
                            }
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('new users')

                              ///LogIn.registerNumber
                              .doc(LoginResponsive.registerNumber)
                              .collection("notification")
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data.docs;
                              List<NotifyDB> notifyData = [];

                              for (var message in messages) {
                                final messageDescription =
                                    message['description'];
                                final sampleNotify = NotifyDB(
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');

                                notifyData.add(sampleNotify);
                              }
                              return Column(
                                children: notifyData,
                              );
                            }
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('new users')

                              ///LogIn.registerNumber
                              .doc(LoginResponsive.registerNumber)
                              .collection("Subject Notification")
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data.docs;
                              List<NotifyDB> notifyData = [];

                              for (var message in messages) {
                                final messageDescription =
                                    message['description'];
                                final sampleNotify = NotifyDB(
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');

                                notifyData.add(sampleNotify);
                              }
                              return Column(
                                children: notifyData,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // );
  }
}

// ignore: must_be_immutable
class NotifyDB extends StatelessWidget {
  NotifyDB({this.imagepath, this.description});
  String imagepath;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(5.0),
              //height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(2)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      // height: 100,
                      // width: 100,
                      child: Image.asset(
                        "images/alert.png",
                        width: 100,
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child:
                          Text("$description", style: TextStyle(fontSize: 15)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
