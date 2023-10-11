import 'package:hive_flutter/hive_flutter.dart';
part 'password_model.g.dart';

@HiveType(typeId: 0)
class PassWordModel {
  @HiveField(0)
  String? password;
  @HiveField(1)
  String? complexity;
  PassWordModel({required this.password, required this.complexity});
}

class PasswordBox {
  static Box<PassWordModel>? _box;
  static Box<PassWordModel> getInstance() {
    return _box ??= Hive.box("allpassword");
  }
}
