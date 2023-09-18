import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact/widget/contact_form.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactEditPage extends StatelessWidget {
  final Contact editedContact;
  final int editedContactIndex;
  const ContactEditPage({
    super.key,
    required this.editedContact,
    required this.editedContactIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit'),
        ),
        body: ContactForm(
          editedContact: editedContact,
          editedContactIndex: editedContactIndex,
        ));
  }
}
