part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}
class ProfileImageChanged extends AccountState {}
class UpdateDone extends AccountState {}
class UpdateLoading extends AccountState {}
class UpdateFailed extends AccountState {}