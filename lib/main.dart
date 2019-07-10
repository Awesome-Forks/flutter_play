import 'package:flutter/material.dart';
import 'editor.dart';
void main(){
  runApp(app());
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Editor(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
