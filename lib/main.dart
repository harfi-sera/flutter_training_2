import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training_2/detail.dart';
import 'package:flutter_training_2/listData.dart';
import 'package:flutter_training_2/login.dart';
import 'package:flutter_training_2/maps.dart';
import 'package:flutter_training_2/register.dart';
import 'package:flutter_training_2/home.dart';
import 'package:flutter_training_2/scan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "page_login": (context) => LoginWidget(),
        "page_register": (context) => RegisterWidget(),
        "page_home": (context) => HomeWidget(),
        "page_scan": (context) => ScanWidget(),
        "page_maps": (context) => MapsWidget(),
        "page_list": (context) => ListDataWidget(),
        "page_detail": (context) => DetailWidget()
      },
      initialRoute: "page_home"));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Apps",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
          ),
          body: ListView(
            children: [
              Image.asset("images/instagram.png"),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, bottom: 10.0, top: 10.0),
                  child: Text("Flutter Apps")),
              TextFormField(),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () => {},
                        child: Text("Button 1")),
                    TextButton(onPressed: () => {}, child: Text("Button 2")),
                    OutlinedButton(
                        onPressed: () => {}, child: Text("Button 6")),
                    IconButton(onPressed: () => {}, icon: Icon(Icons.check)),
                  ],
                ),
              ),
              Divider(
                color: Colors.blue,
                height: 3,
                thickness: 5,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Text("We are ..."),
              ),
              Text("Copyright 2021")
            ],
          )),
    );
  }
}
