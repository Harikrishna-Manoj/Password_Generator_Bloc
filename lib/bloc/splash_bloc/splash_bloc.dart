import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:passwordgenerator/page_home/screen_home.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<GetHomeScreen>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            // ignore: prefer_const_constructors
            builder: (context) => ScreenHome(),
          ));
    });
  }
}
