part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetPasswordEvent extends HomeEvent {
  final String complexity;
  final int length;

  GetPasswordEvent(this.complexity, this.length);
}
