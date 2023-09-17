import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({super.key, required this.contactIndex});
  final int contactIndex;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final displayContact = model.contacts[contactIndex];
        return ListTile(
            title: Text(displayContact.name),
            subtitle: Text(displayContact.email),
            trailing: IconButton(
              onPressed: () {
                model.changeFavoriteStatus(contactIndex);
              },
              icon: Icon(
                  displayContact.isFavorite ? Icons.star : Icons.star_border,
                  color:
                      displayContact.isFavorite ? Colors.amber : Colors.grey),
            ));
      },
    );
  }
}
