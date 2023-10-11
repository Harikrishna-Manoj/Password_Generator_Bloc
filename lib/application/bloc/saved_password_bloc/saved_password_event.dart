part of 'saved_password_bloc.dart';

class SavedPasswordEvent {}

class GetAllPassword extends SavedPasswordEvent {}

class RemoveFromDataBase extends SavedPasswordEvent {
  final String? id;

  RemoveFromDataBase({required this.id});
}
