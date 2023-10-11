part of 'saved_password_bloc.dart';

class SavedPasswordState {
  final List<PassWordModel> passwordList;

  SavedPasswordState({required this.passwordList});
}

class SavedPasswordInitial extends SavedPasswordState {
  SavedPasswordInitial({required super.passwordList});
}
