import 'package:flutter/material.dart';
import 'package:flutter_training_2/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterWidget extends StatefulWidget {
  // const RegisterWidget({Key key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  var isChecked = false;
  var isObscure = true;
  var isObscureCfr = true;
  TextEditingController t1 = TextEditingController(); // password
  TextEditingController t2 = TextEditingController(); // email
  TextEditingController t3 = TextEditingController(); // nama
  TextEditingController t4 = TextEditingController(); // telp

  var f = GlobalKey<FormState>();

  submitData() async {
    var api = Uri.http(BASE_URL, "api/register");

    var email = t2.text;
    var nama = t3.text;
    var pwd = t1.text;
    var telp = t4.text;

    final json = await http
        .post(api, body: {"a": email, "b": nama, "c": pwd, "d": telp});
    print(json.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: f,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("Email"))),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: TextFormField(
                        controller: t2,
                        maxLength: 20,
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("Full Name"))),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        maxLength: 20,
                        controller: t3,
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(labelText: "Name"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("Password"))),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: TextFormField(
                        controller: t1,
                        maxLength: 20,
                        obscureText: isObscure,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefix: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              child: Icon(isObscure
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye),
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            )),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 3) {
                            return "Minimum 3 Character";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("Re-Password"))),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: TextFormField(
                        maxLength: 20,
                        obscureText: isObscureCfr,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefix: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              child: Icon(isObscureCfr
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye),
                              onTap: () {
                                setState(() {
                                  isObscureCfr = !isObscureCfr;
                                });
                              },
                            )),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 3) {
                            return "Minimum 3 Character";
                          } else if (value != t1.text) {
                            return "Password must match";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Center(child: Text("Phone Number"))),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        controller: t4,
                        maxLength: 14,
                        autofocus: false,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(labelText: "Phone Number"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Phone Number is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ))
              ],
            ),
            CheckboxListTile(
                title: Text("Remember Me"),
                value: isChecked,
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
                onChanged: (value) => {
                      setState(() {
                        isChecked = value;
                      })
                    }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (f.currentState.validate()) {
                      submitData();

                      Fluttertoast.showToast(msg: "Registrasi Berhasil");

                      t1.text = "";
                      t2.text = "";
                      t3.text = "";
                      t4.text = "";

                      Navigator.pushReplacementNamed(context, "page_login");
                    }
                  },
                  child: Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
