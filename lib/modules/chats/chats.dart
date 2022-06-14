import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revision_1/main.dart';
import 'package:revision_1/modules/Search/search.dart';
import 'package:revision_1/modules/chats/cubit/chats_cubit.dart';

import '../../shared/componants/componants.dart';

class Chats extends StatefulWidget {
  Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..GetChatList(),
      child:  Scaffold(
          floatingActionButton:BlocBuilder<ChatsCubit, ChatsState>(
        builder: (context, state) {
          // TODO: implement listener
        return FloatingActionButton(
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () {
             // BlocProvider.of<ChatsCubit>(context).getOneItem();
            },
            child: Icon(
              Icons.message_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          );}),
          backgroundColor: Colors.deepPurple,
          body: BlocBuilder<ChatsCubit, ChatsState>(builder: (context, state) {
            if (state is ChatLIstLoading) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              'Chatify',
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                            Spacer(),
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(SearchScreen.pageName);
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: BlocBuilder<ChatsCubit, ChatsState>(
                        builder: (context, state) {
                          return Container(
                            
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(45),
                                                      topRight: Radius.circular(45))),
                                              child: (BlocProvider.of<ChatsCubit>(context)
                                                          .ChatList
                                                          .isEmpty) ?Container(width: double.infinity,child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[ SvgPicture.asset ('assets/images/1.svg',height: 160,width: 100,),SizedBox(height: 20,),Text('No messages yet .',style:TextStyle(fontSize:20,color:Colors.grey.withOpacity(.5)))])):

                                              
                                              
                                              
                                              
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:8.0),
                                                    child: Container(
                                                    height: 100,
                                                        
                                                        child: ListView(
                                                            physics: BouncingScrollPhysics(),
                                                            scrollDirection: Axis.horizontal,
                                                            children:BlocProvider.of<ChatsCubit>(
                                                                        context)
                                                                    .ChatList
                                                                    .map((e) =>
                                                                        ChatItemBuilder(e))
                                                                    .toList())
                                                            ),
                                                  ),SizedBox(height: 26,),
                                                    
                                                  
                                                  Expanded(child: Container(
                                                          width: double.infinity,
                                                          child: ListView(
                                                              shrinkWrap: true,
                                                              physics: BouncingScrollPhysics(),
                                                              children: BlocProvider.of<ChatsCubit>(
                                                                      context)
                                                                  .ChatList
                                                                  .map((e) =>
                                                                      ChatListItemBuilder(context, e))
                                                                  .toList())),
                                                      )
                                                ],
                                              ),
                                            );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          }),
        ),
      );
  }
}
