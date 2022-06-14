part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class PasswordBottomEnabled extends ProfileState {}
class PasswordBottomDisabled extends ProfileState {}
class ProfileImageChanged extends ProfileState {}
class ProfileInfosLoaded extends ProfileState {}
class ProfileInfosLoading extends ProfileState {}


