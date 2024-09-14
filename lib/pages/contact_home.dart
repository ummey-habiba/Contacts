import 'package:contacts/pages/new_contact.dart';
import 'package:flutter/material.dart';

class ContactHome extends StatelessWidget {
  static const String routeName = '/';

  const ContactHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          NewContact.routeName,
        ),
        child:  const Icon(Icons.add),

      ),
    );
  }
}
