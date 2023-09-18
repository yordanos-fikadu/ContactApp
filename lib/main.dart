import 'package:contact_app/ui/contact/contact_create_page.dart';
import 'package:contact_app/ui/contact_list/contact_list_page.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactsModel>(
      model: ContactsModel(),
      child: MaterialApp(
        title: 'Contact',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactListPage(),
      ),
    );
  }
}
