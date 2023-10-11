import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:passwordgenerator/application/bloc/home_bloc/home_bloc.dart';
import 'package:passwordgenerator/application/bloc/saved_password_bloc/saved_password_bloc.dart';
import 'package:passwordgenerator/application/bloc/splash_bloc/splash_bloc.dart';
import 'package:passwordgenerator/domain/model/password_model.dart';
import 'package:passwordgenerator/infrastructure/db_funcion.dart';

import 'package:passwordgenerator/presentation/page_splash/screen_splash.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PassWordModelAdapter());
  openDatabase();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => SavedPasswordBloc(),
          )
        ],
        child: MaterialApp(
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const ScreenSplash(),
        ));
  }
}
