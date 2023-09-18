import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) {
                _name = newValue!;
              },
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
              validator: _emailValidator,
              decoration: InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
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
      final contact =
          Contact(name: _name, email: _email, phoneNumber: _phoneNumber);
      ScopedModel.of<ContactsModel>(context).addContact(contact);
      Navigator.of(context).pop();
    }
  }
}
