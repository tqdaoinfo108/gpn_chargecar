import 'package:flutter/material.dart';

class ScaffoldDefault extends StatelessWidget {
  const ScaffoldDefault(this.title, this.body, {Key? key}) : super(key: key);
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
