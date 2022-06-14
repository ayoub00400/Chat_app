import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/modules/chats/cubit/chats_cubit.dart';
import 'package:revision_1/modules/login/cubit/login_cubit.dart';
import 'package:revision_1/shared/componants/componants.dart';

class Contacts extends StatefulWidget {
  //Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..GetContacts(),
      child: Scaffold(
        body: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            if (state is ContactsProccesed) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (state is ContactsFailed) {
                return Center(child: Text('Sorry,Error try later ..  '));
              } else {
                return (BlocProvider.of<ChatsCubit>(context)
                            .contacts.isEmpty)?Center(child: Text('No contacts found.',style:TextStyle(fontSize:20,color:Colors.grey.withOpacity(.5)))):Container(
                    width: double.infinity,
                    color: Colors.white,
                    // padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ListView(
                        children: BlocProvider.of<ChatsCubit>(context)
                            .contacts
                            .map((e) => ChatListItemBuilder1(context, e))
                            .toList() as List<Widget>));
              }
            }
          },
        ),
      ),
    );
  }
}
