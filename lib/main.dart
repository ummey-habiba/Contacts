import 'package:contacts/pages/contact_home.dart';
import 'package:contacts/pages/details.dart';
import 'package:contacts/pages/new_contact.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create:(context) => ContactProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:ContactHome.routeName,
      routes:{
        ContactHome.routeName:(context) =>const ContactHome(),
        NewContact.routeName:(context) =>const NewContact(),
        Details.routeName:(context) =>const Details(),
      },
    );
  }
}




