part of 'home_bloc.dart';

class HomeState {
  final String password;

  HomeState({required this.password});
}

class HomeInitial extends HomeState {
  HomeInitial({required super.password});
}
