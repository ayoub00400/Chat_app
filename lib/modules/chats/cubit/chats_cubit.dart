import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:revision_1/main.dart';
import 'package:revision_1/shared/Local/localstorage.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  List<String> ChatList=[];
   List<dynamic>contacts=[];
  List<Map<String,dynamic>?>allchats=[];
  ChatsCubit() : super(ChatsInitial());

  GetChatList(){
    emit(ChatLIstLoading());
    Myapp.fire_cloud_store.collection('users').doc(Myapp.local_storage.getString('uid')).collection('chats').get().then((value){
     ChatList=value.docs.map((e) => e.id).toList();
     emit(ChatLIstReady());
    }).catchError((error){print('KKKKKKKKKyna eroor 404');
    emit(ChatLIstFailed());
    });
  }


  GetContacts(){
    print('rani f lget contacts');
     emit(ContactsProccesed());
   Myapp.fire_cloud_store.collection('users').doc(Myapp.local_storage.getString('uid')).collection('chats').get().then((value){
     contacts =value.docs.map((e) => e.id).toList();
     print(contacts);
     emit(ContactsSeccess());
    }).catchError((error){print('KKKKKKKKKyna eroor 404');
    emit(ContactsFailed());
    });

  }
}
