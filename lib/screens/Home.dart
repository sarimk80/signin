import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String token;

  Home({@required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
      ),
      body: Center(
        child: Text(this.token),
      ),
    );
  }
}
