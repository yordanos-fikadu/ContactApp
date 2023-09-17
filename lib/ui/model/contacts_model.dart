import 'dart:ui';

import 'package:contact_app/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  final List<Contact> _contacts = List.generate(
      30,
      (index) => Contact(
          name: '${Faker().person.firstName()}  ${Faker().person.lastName()}',
          email: Faker().internet.email(),
          phoneNumber: Faker().randomGenerator.integer(10000).toString()));
  List<Contact> get contacts => _contacts;
  void changeFavoriteStatus(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _contacts.sort(
      (a, b) {
        if (a.isFavorite) {
          return -1;
        } else if (b.isFavorite) {
          return 1;
        } else {
          return 0;
        }
      },
    );
    notifyListeners();
  }
}
