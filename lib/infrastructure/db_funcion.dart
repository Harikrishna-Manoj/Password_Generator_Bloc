import 'package:hive_flutter/adapters.dart';
import 'package:passwordgenerator/domain/model/password_model.dart';

late Box<PassWordModel> favouritDatabase;
openDatabase() async {
  favouritDatabase = await Hive.openBox<PassWordModel>("allpassword");
}
