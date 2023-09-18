import 'dart:io';

import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact/contact_edit_page.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({super.key, required this.contactIndex});
  final int contactIndex;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: null,
          label: 'Email',
          backgroundColor: Colors.green,
          icon: Icons.email,
        ),
        SlidableAction(
          onPressed: null,
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
        ),
      ]),
      endActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            ScopedModel.of<ContactsModel>(context).deleteContact(contactIndex);
          },
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
        ),
      ]),
      child: _buildContent(context),
    );
  }

  ListTile _buildContent(BuildContext context) {
    final model = ScopedModel.of<ContactsModel>(context);
    final displayContact = model.contacts[contactIndex];
    return ListTile(
      leading: _buildCircleAvator(displayContact),
      title: Text(displayContact.name),
      subtitle: Text(displayContact.email),
      trailing: IconButton(
        onPressed: () {
          model.changeFavoriteStatus(contactIndex);
        },
        icon: Icon(displayContact.isFavorite ? Icons.star : Icons.star_border,
            color: displayContact.isFavorite ? Colors.amber : Colors.grey),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ContactEditPage(
                editedContact: displayContact,
                editedContactIndex: contactIndex)));
      },
    );
  }

  Hero _buildCircleAvator(Contact displayContact) {
    return Hero(
      tag: displayContact.hashCode,
      child: CircleAvatar(
        child: _buildCircleAvatorContent(displayContact),
      ),
    );
  }

  Widget _buildCircleAvatorContent(Contact displayContact) {
    if (displayContact.imageFile == null) {
      return Text(displayContact.name[0]);
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(File(displayContact.imageFile!.path),fit: BoxFit.cover),
        ),
      );
    }
  }
}
