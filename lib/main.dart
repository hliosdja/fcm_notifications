import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification/notification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  List<Messages> messages = [];
  // String title;
  // String body;
  // String payload;

  Future<String> getDeviceToken() async {
    String token;
    token = await _fcm.getToken();
    print('token: $token');
    return token;
  }

  @override
  void initState() {
    super.initState();
    NotificationHandler.init();
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    getDeviceToken();
    _fcm.configure(onMessage: (Map<String, dynamic> message) {
      final notification = message['notification'];
      // title = notification['title'];
      // body = notification['body'];
      // payload = 'birthday.payload';
      NotificationHandler.showNotifications(
        title: notification['title'] != null ? notification['title'] : null,
        body: notification['body'] != null ? notification['body'] : null,
        payload: 'this the first notification',
      );
      setState(() {
        messages.add(
            Messages(title: notification['title'], body: notification['body']));
      });
      print('onMessage: $message');
    }, onLaunch: (Map<String, dynamic> message) {
      final notification = message['notification'];
      NotificationHandler.showNotifications(
        title: notification['title'] != null ? notification['title'] : null,
        body: notification['body'] != null ? notification['body'] : null,
        payload: 'this the first notification',
      );
      setState(() {
        messages.add(
            Messages(title: notification['title'], body: notification['body']));
      });
      print('onLaunch: $message');
    }, onResume: (Map<String, dynamic> message) {
      final notification = message['notification'];
      NotificationHandler.showNotifications(
        title: notification['title'] != null ? notification['title'] : null,
        body: notification['body'] != null ? notification['body'] : null,
        payload: 'this the first notification',
      );
      setState(() {
        messages.add(
            Messages(title: notification['title'], body: notification['body']));
      });
      print('onResume: $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index].body),
                    subtitle: Text(messages[index].title),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     NotificationHandler.showNotifications(
            //       // title: notification['title'] != null ? notification['title'] : null,
            //       // body: notification['body'] != null ? notification['body'] : null,
            //       // payload: 'this the first notification',
            //       title: title,
            //       body: body,
            //       payload: payload,
            //     );
            //   },
            //   child: Text('Release notification'),
            // ),
          ],
        ),
      ),
    );
  }
}

class Messages {
  final String title;
  final String body;

  Messages({@required this.title, @required this.body});
}
