part of 'splash_bloc.dart';

@immutable
class SplashEvent {}

// ignore: must_be_immutable
class GetHomeScreen extends SplashEvent {
  BuildContext context;
  GetHomeScreen(this.context);
}
