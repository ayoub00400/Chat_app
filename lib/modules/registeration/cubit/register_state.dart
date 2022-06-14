part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterDone extends RegisterState {}
class RegisterFailed extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegistrationImageChanged extends RegisterState{}