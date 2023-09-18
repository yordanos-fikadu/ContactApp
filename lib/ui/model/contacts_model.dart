import 'dart:ui';

import 'package:contact_app/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  final List<Contact> _contacts = List.generate(
      5,
      (index) => Contact(
          name: '${Faker().person.firstName()}  ${Faker().person.lastName()}',
          email: Faker().internet.email(),
          phoneNumber: Faker().randomGenerator.integer(10000).toString()));
  List<Contact> get contacts => _contacts;
  void changeFavoriteStatus(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _sortContact();
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void updateContact(Contact contact, int contactIndex) {
    _contacts[contactIndex] = contact;
    notifyListeners();
  }

  void _sortContact() {
    _contacts.sort(
      (a, b) {
        int comparisonResult;
        comparisonResult = _compareBasedOnFavoriteStatus(a, b);
        if (comparisonResult == 0) {
          comparisonResult = _compareAlphabetically(a, b);
        }
        return comparisonResult;
      },
    );
  }

  int _compareBasedOnFavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      return -1;
    } else if (b.isFavorite) {
      return 1;
    } else {
      return 0;
    }
  }

  int _compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
}
