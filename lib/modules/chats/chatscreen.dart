import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revision_1/main.dart';
import 'package:revision_1/shared/Local/localstorage.dart';
import 'package:revision_1/shared/componants/componants.dart';

class ChatScreen extends StatefulWidget {
  static String pageName = 'Chatbox';
  @override
  _ChatScreen createState() {
    return _ChatScreen();
  }
}

class _ChatScreen extends State<ChatScreen> {
  dynamic args;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> msgs = [];

  TextEditingController myMsg = TextEditingController();
  SendMessage() async {
    Myapp.fire_cloud_store
        .collection('users')
        .doc(Myapp.local_storage.getString('uid'))
        .collection('chats')
        .doc(args['useruid']).set({'random':'data'}).then((value){
           Myapp.fire_cloud_store
        .collection('users')
        .doc(Myapp.local_storage.getString('uid'))
        .collection('chats')
        .doc(args['useruid'])
        .collection('messages')
        .add({
      'From': Myapp.local_storage.getString('uid'),
      'content': myMsg.text,
      'date': DateTime.now()
    }).then((value) {
      print('Message sent save on me ');
      
    });
        });
   

Myapp.fire_cloud_store
        .collection('users')
        .doc(args['useruid'])
        .collection('chats')
        .doc(Myapp.local_storage.getString('uid') ).set({'random':'data'}).then((value){


            Myapp.fire_cloud_store
        .collection('users')
        .doc(args['useruid'])
        .collection('chats')
        .doc(Myapp.local_storage.getString('uid') )
        .collection('messages')
        .add({
      'From': Myapp.local_storage.getString('uid'),
      'content': myMsg.text,
      'date': DateTime.now()
    }).then((value) {
      print('Message sent to houda');
      myMsg.text = '';
    });



        });
    






  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as Map;
    Stream<QuerySnapshot<Map<String, dynamic>>> response = Myapp
        .fire_cloud_store
        .collection('users')
        .doc(Myapp.local_storage.getString('uid'))
        .collection('chats')
        .doc(args['useruid'])
        .collection('messages').orderBy('date')
        .snapshots();
    ;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        titleSpacing: 1,
        title: Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    args['args']['profile_image']),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                args['args']['username'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ])),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder<dynamic>(
                  stream: response,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    msgs = [];
                    msgs = snapshot.data!.docs;
                    print( msgs.reversed.toList());
                    //print(msgprins[0].data());
                    return Container(
                        child: SingleChildScrollView(
                          reverse: true,
                            physics: BouncingScrollPhysics(),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: msgs.toList()
                                    .map((e) =>
                                        BuildChatMessage(context, e.data()))
                                    .toList() as List<Widget>)));
                  }),
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: TextField(
                        controller: myMsg,
                        decoration: InputDecoration(
                            hintText: 'Type ....',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)))),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      SendMessage();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.deepPurple,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
