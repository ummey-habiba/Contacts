import 'package:contacts/database/db_helpepr.dart';
import 'package:contacts/models/contact_model.dart';
import 'package:flutter/foundation.dart';

class ContactProvider with ChangeNotifier{
List<ContactModel>_contactList=[];
List<ContactModel> get contactList=> _contactList;
final _db= DbHelper();
Future<int> addContact(ContactModel contact){
  return _db.insertContact(contact);
}
}