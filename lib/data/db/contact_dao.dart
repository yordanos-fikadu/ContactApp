import 'package:contact_app/data/contact.dart';
import 'package:contact_app/data/db/app_database.dart';
import 'package:sembast/sembast.dart';

class ContactDao {
  static const String CONTACT_STORE_NAME = 'contacts';
  final _contactStore = intMapStoreFactory.store(CONTACT_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;
  Future insert(Contact contact) async {
    await _contactStore.add(await _db, contact.toMap());
  }

  Future update(Contact contact) async {
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.update(await _db,contact.toMap(),finder: finder);
  }
  Future delete(Contact contact) async {
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.delete(await _db, finder: finder);
  }
}
