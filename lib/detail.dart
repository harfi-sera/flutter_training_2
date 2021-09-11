import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training_2/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DetailWidget extends StatefulWidget {
  DetailWidget({Key key, @required this.id}) : super(key: key);

  final String id;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  var idItem = "";

  var t1 = TextEditingController();
  var t2 = TextEditingController();
  var t3 = TextEditingController();

  getRegisterData(id) async {
    await Future.delayed(Duration(seconds: 2));

    var api = Uri.http(BASE_URL, "api/data/" + id);

    final response = await http.get(api);
    var hasil = json.decode(response.body) as Map<String, dynamic>;
    var data = hasil["data"];

    t1.text = data["email"];
    t2.text = data["nama"];
    t3.text = data["telp"];

    return response;
  }

  updateRegisterData() async {
    await Future.delayed(Duration(seconds: 2));

    var api = Uri.http(BASE_URL, "api/data");

    final response = await http.put(api,
        body: {"a": idItem, "b": t1.text, "c": t2.text, "d": t3.text});
    var hasil = json.decode(response.body) as Map<String, dynamic>;

    return hasil["status"];
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> f = GlobalKey();
    idItem = ModalRoute.of(context).settings.arguments.toString();
    getRegisterData(idItem);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: f,
              child: ListView(
                children: [
                  TextFormField(
                    controller: t1,
                    maxLength: 30,
                    autofocus: true,
                  ),
                  TextFormField(
                    controller: t2,
                  ),
                  TextFormField(
                    controller: t3,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        updateRegisterData().then((value) =>
                            {Fluttertoast.showToast(msg: "Success")});
                      },
                      child: Text("Submit"))
                ],
              )),
        ),
      ),
    );
  }
}
