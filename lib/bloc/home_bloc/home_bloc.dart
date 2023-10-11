import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(password: '')) {
    on<GetPasswordEvent>((event, emit) {
      String uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      String lowercaseLetters = "abcdefghijklmnopqrstuvwxyz";
      String numbers = "0123456789";
      String symbols = "~!@#%^&*()><{}[]+=_|/";
      String password = '';
      if (event.complexity == 'Easy') {
        password = lowercaseLetters + uppercaseLetters;
      } else if (event.complexity == 'Medium') {
        password = lowercaseLetters + uppercaseLetters + numbers;
      } else if (event.complexity == 'Hard') {
        password = lowercaseLetters + uppercaseLetters + numbers + symbols;
      }
      password = passwordGenerator(event.length, password);
      print(password);
      print(event.complexity);
      emit(HomeInitial(password: password));
    });
  }
}

String passwordGenerator(int length, String password) {
  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(password.length);
    return password[indexRandom];
  }).join('');
}
