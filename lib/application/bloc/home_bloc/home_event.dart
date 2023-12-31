part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetPasswordEvent extends HomeEvent {
  final String complexity;
  final int length;

  GetPasswordEvent(this.complexity, this.length);
}

class AddPasswordToDataBase extends HomeEvent {
  final PassWordModel data;

  AddPasswordToDataBase(this.data);
}

class CopyPassword extends HomeEvent {
  final String password;

  CopyPassword(this.password);
}
