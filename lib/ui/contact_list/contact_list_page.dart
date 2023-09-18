import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact/contact_create_page.dart';
import 'package:contact_app/ui/contact_list/widget/contact_tile.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          return ListView.builder(
            itemCount: model.contacts.length,
            itemBuilder: (context, index) {
              return ContactTile(contactIndex: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ContactCreatePage(),
            ));
          },
          child: Icon(Icons.add)),
    );
  }
}
