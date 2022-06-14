part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}
class ChatLIstLoading extends ChatsState {}
class ChatLIstReady extends ChatsState {}
class ChatLIstReady2 extends ChatsState {}
class ChatLIstFailed extends ChatsState {}
class ContactsSeccess extends ChatsState {}

class ContactsFailed extends ChatsState {}

class ContactsProccesed extends ChatsState {}
