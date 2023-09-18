import 'dart:io';

import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  final Contact? editedContact;
  final int? editedContactIndex;
  const ContactForm({
    super.key,
    this.editedContact,
    this.editedContactIndex,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late String _name;
  late String _email;
  late String _phoneNumber;
  File? _contactImageFile;
  bool get isEditMode => widget.editedContact != null;
  bool get hasSelectedCustomImage => _contactImageFile != null;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contactImageFile = widget.editedContact?.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            _buildContactPicture(),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) {
                _name = newValue!;
              },
              initialValue: widget.editedContact?.name,
              validator: _nameValidator,
              decoration: InputDecoration(
                  label: Text('Name'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) {
                _email = newValue!;
              },
              initialValue: widget.editedContact?.email,
              validator: _emailValidator,
              decoration: InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.editedContact?.phoneNumber,
              onSaved: (newValue) {
                _phoneNumber = newValue!;
              },
              validator: _phoneValidator,
              decoration: InputDecoration(
                  label: Text('PhoneNumber'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
                onPressed: _onSavedButtonPresed,
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Save Contact',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.white,
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 2;
    return GestureDetector(
      onTap: _onContactPictureTaped,
      child: Hero(
        tag: widget.editedContact?.hashCode ?? 0,
        child: CircleAvatar(
          radius: halfScreenDiameter / 2,
          child: _buildCircularAvatarContent(halfScreenDiameter),
        ),
      ),
    );
  }

  Future<void> _onContactPictureTaped() async {
    final imageFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    setState(() {
      _contactImageFile = File(imageFile!.path);
    });
  }

  Widget _buildCircularAvatarContent(double halfScreenDiameter) {
    if (isEditMode || hasSelectedCustomImage) {
      return _buildEditModeCircleAvatorContent(halfScreenDiameter);
    } else {
      return Icon(
        Icons.person,
        size: halfScreenDiameter / 2,
      );
    }
  }

  Widget _buildEditModeCircleAvatorContent(double halfScreenDiameter) {
    if (_contactImageFile == null) {
      return Text(
        widget.editedContact!.name[0],
        style: TextStyle(fontSize: halfScreenDiameter / 2),
      );
    } else {
      return ClipOval(
        child: AspectRatio(
            aspectRatio: 1,
            child: Image.file(
              _contactImageFile!,
              fit: BoxFit.cover,
            )),
      );
    }
  }

  String? _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Enter a name';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    final emailRegx = RegExp(
        r"^[A-Za-z0-9](([a-zA-Z0-9,=\.!\-#|\$%\^&\*\+/\?_`\{\}~]+)*)@(?:[0-9a-zA-Z-]+\.)+[a-zA-Z]{2,9}$");
    if (value!.isEmpty) {
      return 'Enter a email';
    } else if (!emailRegx.hasMatch(value)) {
      return 'Enter a Valid Email Address';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    final phoneRegx = RegExp(r'^([0-9])');
    if (value!.isEmpty) {
      return 'Enter a phoneNuber';
    } else if (!phoneRegx.hasMatch(value)) {
      return 'Enter a Valid phoneNumber';
    }
    return null;
  }

  void _onSavedButtonPresed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final newOrEditedContact = Contact(
          name: _name,
          email: _email,
          phoneNumber: _phoneNumber,
          isFavorite: widget.editedContact?.isFavorite ?? false,
          imageFile: _contactImageFile);
      if (isEditMode) {
        newOrEditedContact.id = widget.editedContact!.id;
        ScopedModel.of<ContactsModel>(context)
            .updateContact(newOrEditedContact, widget.editedContactIndex!);
      } else {
        ScopedModel.of<ContactsModel>(context).addContact(newOrEditedContact);
      }
      Navigator.of(context).pop();
    }
  }
}
