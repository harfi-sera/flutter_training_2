import 'package:flutter/material.dart';

class TodoItem {
  String title;
  bool done;

  TodoItem({@required this.title, @required this.done});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['done'] = done;

    return m;
  }
}
