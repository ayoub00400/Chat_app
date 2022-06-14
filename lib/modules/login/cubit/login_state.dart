part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}


class LoginSeccess extends LoginState {}

class LoginFailed extends LoginState {}

class LoginProccesed extends LoginState {}

