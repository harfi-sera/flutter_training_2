import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training_2/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ListDataWidget extends StatefulWidget {
  ListDataWidget({Key key}) : super(key: key);

  @override
  _ListDataWidgetState createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<ListDataWidget> {
  getRegisterData() async {
    await Future.delayed(Duration(seconds: 3));

    var api = Uri.http(BASE_URL, "api/data");

    final data = await http.get(api);
    var response = json.decode(data.body) as Map<String, dynamic>;

    return response;
  }

  deleteRegisterData(id) async {
    await Future.delayed(Duration(seconds: 2));

    var api = Uri.http(BASE_URL, "api/data/" + id);

    final data = await http.delete(api);
    var response = json.decode(data.body) as Map<String, dynamic>;

    if (response["status"] == true) {
      Fluttertoast.showToast(msg: "Delete Success");
    } else {
      Fluttertoast.showToast(msg: "Delete Failed");
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
        centerTitle: true,
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () => getRegisterData(),
          child: FutureBuilder(
              future: getRegisterData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  var dataJson = snapshot.data as Map<String, dynamic>;
                  var dataListTemp = dataJson["data"];

                  return ListView.builder(
                      itemCount: dataListTemp.length,
                      itemBuilder: (context, index) {
                        var data = dataListTemp[index];

                        return Dismissible(
                          confirmDismiss: (direction) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Confirmation"),
                                    content: Text(
                                        "Are you sure to delete this data?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text("Yes")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text("No"))
                                    ],
                                  );
                                });
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              deleteRegisterData(data["id"].toString());
                            }
                          },
                          direction: DismissDirection.startToEnd,
                          key: Key(data["id"].toString()),
                          child: ListTile(
                            onTap: () {
                              var id = data["id"].toString();
                              Navigator.pushNamed(context, "page_detail",
                                  arguments: id);
                            },
                            title: Text(data["email"]),
                            subtitle: Text(data["nama"] + " " + data["telp"]),
                            leading: Icon(Icons.person),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text("Please try again"),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
