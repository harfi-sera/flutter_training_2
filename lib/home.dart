import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:localstorage/localstorage.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("images/instagram.png"),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        image: AssetImage("images/background.jpeg"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                title: Text("Home"),
                subtitle: Text("This is dashboard"),
                leading: Icon(Icons.home, color: Colors.blue),
                onTap: () {},
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.star, color: Colors.blue),
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "Created By Harfi Novian",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
              ),
              ListTile(
                title: Text("Maps"),
                leading: Icon(Icons.map, color: Colors.blue),
                onTap: () {
                  Navigator.pushNamed(context, "page_maps");
                },
              ),
              ListTile(
                title: Text("List"),
                leading: Icon(Icons.list, color: Colors.blue),
                onTap: () {
                  Navigator.pushNamed(context, "page_list");
                },
              ),
              ListTile(
                title: Text("Scan"),
                leading: Icon(Icons.qr_code, color: Colors.blue),
                onTap: () async {
                  // You can request multiple permissions at once.
                  Map<Permission, PermissionStatus> statuses =
                      await [Permission.camera, Permission.storage].request();

                  if (statuses[Permission.camera].isGranted &&
                      statuses[Permission.storage].isGranted) {
                    var cameraScanResult = await scanner.scan();
                    Fluttertoast.showToast(msg: cameraScanResult);
                  } else if (statuses[Permission.camera] ==
                          PermissionStatus.permanentlyDenied ||
                      statuses[Permission.storage] ==
                          PermissionStatus.permanentlyDenied) {
                    Fluttertoast.showToast(msg: "Denied");
                    await openAppSettings();
                  }
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app, color: Colors.blue),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "page_login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
