import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordgenerator/bloc/splash_bloc/splash_bloc.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SplashBloc>(context).add(GetHomeScreen(context));
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset(
          'asset/password_generator.png',
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
