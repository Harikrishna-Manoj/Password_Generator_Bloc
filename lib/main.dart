import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordgenerator/bloc/home_bloc/home_bloc.dart';
import 'package:passwordgenerator/bloc/splash_bloc/splash_bloc.dart';
import 'package:passwordgenerator/page_splash/screen_splash.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
          )
        ],
        child: MaterialApp(
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const ScreenSplash(),
        ));
  }
}
