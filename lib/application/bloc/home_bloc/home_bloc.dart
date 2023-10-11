import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:passwordgenerator/domain/model/password_model.dart';

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
      emit(HomeInitial(password: password));
    });
    on<AddPasswordToDataBase>((event, emit) async {
      final instanceOfDatabase = PasswordBox.getInstance();
      if (instanceOfDatabase.values
          .any((element) => element.password == event.data.password)) {
        Fluttertoast.showToast(msg: "Already saved");
        return;
      }
      await instanceOfDatabase.add(event.data);
      Fluttertoast.showToast(msg: "Saved");
    });
  }
}

String passwordGenerator(int length, String password) {
  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(password.length);
    return password[indexRandom];
  }).join('');
}
