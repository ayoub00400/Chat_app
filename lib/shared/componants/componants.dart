import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revision_1/main.dart';
import 'package:revision_1/modules/chats/chatscreen.dart';
import 'package:revision_1/shared/Local/localstorage.dart';
dynamic userinfos;

getinfo( dynamic Contactuid)async {
  dynamic data;
data =await Myapp.fire_cloud_store.collection('users').doc(Contactuid).get();
return data;
}


Widget ChatListItemBuilder1(BuildContext context,dynamic Contactuid) { 

dynamic GG;

  return FutureBuilder<dynamic>(future:getinfo(Contactuid) ,
    builder:((context, snapshot) {
    if(snapshot.hasData){
      print(snapshot.data.data().toString()+'ffffffffffffffffff');
      GG=snapshot.data.data();
      return 
       Padding(
    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
    child: GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatScreen(),
        settings: RouteSettings(
          // arguments: data.items[index] // <- this does not work
          arguments: {
            'useruid':Contactuid,
            'args':snapshot.data.data(),  // <- read below
          }
        ),));
        
              },
      child:  ListTile(
        
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(snapshot.data.data()['profile_image']
             ),
        ),
        title: Text(snapshot.data.data()['username'].toString()),
        
        
      ),
    ),
  );  }
else{
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Center(child: CircularProgressIndicator(),),
  );
    }}
));
}


Widget SearcheItemBuilder(BuildContext context,QueryDocumentSnapshot<Map<String, dynamic>> e ){

  return Padding(padding: EdgeInsets.all(8),child:ListTile(leading:CircleAvatar(radius: 20, backgroundImage: NetworkImage(e.data()['profile_image']) ),title: Text(e.data()['username']),trailing: TextButton(onPressed:(){
     Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatScreen(),
        settings: RouteSettings(
          // arguments: data.items[index] // <- this does not work
          arguments: {
            'useruid':e.id,
            'args':e.data(),  // <- read below
          }
        ),));
  },child: Text('Send Message')),));
}


Widget ChatItemBuilder(dynamic e) {
  return FutureBuilder<dynamic>(future:getinfo(e) ,
    builder:((context, snapshot) {
    if(snapshot.hasData){
     // print(snapshot.data.data().toString()+'trtrtrt');
      
      return GestureDetector(
      onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(),
          settings: RouteSettings(
           
            arguments: {
              'useruid':e,
              'args':snapshot.data.data(),  // <- read below
            }
          ),));
          
                },
      child: 
  
  Padding(
    padding: const EdgeInsets.only(right: 25),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  snapshot.data.data()['profile_image']),
            ),
          ),
          Container(
              width: 90,
              child: Text(
                snapshot.data.data()['username'],
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
    ),
  ));}else{
    return CircularProgressIndicator();
  }
  
  }));}



Widget BuildChatMessage(BuildContext context,Map<String,dynamic> msg_info){
  if(msg_info['From']==Myapp.local_storage.getString('uid')){
     return 
  Container(
    //color: Colors.amber,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only( right:10,top: 25),
          child: Container(padding: EdgeInsets.all(8),constraints: BoxConstraints(maxWidth: 300,), decoration: BoxDecoration(color: Colors.deepPurple.shade200, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20))), child: SelectableText( msg_info['content']),),
        ),
      ],
    ),
  );
  }else{
     return 
  Container(
    //color: Colors.red,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:10 ,top: 25),
          child: Container(constraints: BoxConstraints(maxWidth: 300), padding: EdgeInsets.all(8),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20))), child: SelectableText(msg_info['content']),)),
      ],
    ),
  );

  }
 
}











Widget ChatListItemBuilder(BuildContext context,dynamic Contactuid) { 

dynamic GG;



  return FutureBuilder<dynamic>(future:getinfo(Contactuid) ,
    builder:((context, snapshot) {
    if(snapshot.hasData){
     // print(snapshot.data.data().toString()+'trtrtrt');
      GG=snapshot.data.data();
      return 
       Container(
         child: GestureDetector(
      onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(),
          settings: RouteSettings(
           
            arguments: {
              'useruid':Contactuid,
              'args':snapshot.data.data(),  // <- read below
            }
          ),));
          
                },
      child:  ListTile(
          
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                snapshot.data.data()['profile_image']),
          ),
          title: Text(snapshot.data.data()['username'].toString()),
          subtitle:  Text('Good Morning Ayoub how are you fghldfhgldfjgld',maxLines:1,overflow: TextOverflow.ellipsis,)
          ,trailing:Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('12:00 pm'),Spacer(),
            Container(alignment: AlignmentDirectional.center, height:20 ,width:35 ,decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),child: Text('200',style: TextStyle(color: Colors.white,),)
      )],) ,
      ),
    ),
       )
  ;  }
else{
  return Center(child:CircularProgressIndicator()) ;
}}
));
}


ProfileItemBuilder(BuildContext context,String mytitle,String mysubtitle, IconData myicon,Widget mytriling,Function myFunc){
  return ListTile(
    onTap: () => myFunc(),
    leading: Icon(myicon,color: Colors.deepPurple,size:32 ,),
    title: Text(mytitle) ,
    subtitle: Text(mysubtitle),
    trailing: mytriling,
  
  );
}

ContactItemBuilder(String mytitle){
  return Container(  

    padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(color: Colors.deepPurple.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
      
      child: Row(children: [CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
              'https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png'),
        ),SizedBox(width: 20,),Text(mytitle,style: TextStyle(fontSize: 16),) ])
  );
}