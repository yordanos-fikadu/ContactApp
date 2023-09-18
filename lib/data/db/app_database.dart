import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;
  late Completer<Database> _dbOpenCompleter;
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatbase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatbase() async {
    // final appDocumentDir = await getApplicationDocumentsDirectory();
    // final dbpath = join(appDocumentDir.path, 'contacts.db');
    final database = await databaseFactoryIo.openDatabase('contacts.db');
    _dbOpenCompleter.complete(database);
  }
}
