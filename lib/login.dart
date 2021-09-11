import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class LoginWidget extends StatelessWidget {
  // const LoginWidget({Key key}) : super(key: key);

  var f = GlobalKey<FormState>();

  TextEditingController t1 = TextEditingController(); // email
  TextEditingController t2 = TextEditingController(); // password

  void validate() {
    final FormState form = f.currentState;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  Future<dynamic> prosesLogin() async {
    var api = Uri.http("192.168.0.3:8000", "api/login");

    var email = t1.text;
    var pass = t2.text;

    final response = await http.post(api, body: {"a": email, "b": pass});
    var hasil = json.decode(response.body);

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 20,
      ),
      body: Form(
        key: f,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                "images/instagram.png",
                width: 50,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                  controller: t1,
                  maxLength: 50,
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email is required";
                    } else if (value.length < 5) {
                      return "Minimum 5 Character";
                    } else if (EmailValidator.validate(value) == false) {
                      return "Invalid email format";
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email",
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      helperText: "Please input your email address",
                      helperStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.email),
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.purple)))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                  controller: t2,
                  maxLength: 20,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 3) {
                      return "Minimum 3 Character";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Password",
                      labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      helperText: "Please input your password",
                      helperStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.purple)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.purple)))),
            ),
            ElevatedButton(
              onPressed: () => {
                if (f.currentState.validate() == true)
                  {
                    prosesLogin().then((value) => {
                          if (value["status"] == true)
                            {
                              Navigator.pushReplacementNamed(
                                  context, "page_home")
                            }
                          else
                            {
                              Fluttertoast.showToast(
                                  msg: "Email or password invalid")
                            }
                        })
                  }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: Text("Login"),
            ),
            Center(
                child: TextButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, "page_register")},
                    child: Text("Sign Up")))
          ],
        ),
      ),
    );
  }
}
