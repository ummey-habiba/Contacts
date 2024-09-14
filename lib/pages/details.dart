import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  static const String routeName='/details';
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:const Text('Details'),),
    );
  }
}
