/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revision_1/modules/profile/cubit/cubit/account_cubit.dart';
class AccountScreen extends StatefulWidget {
  //AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  
  TextEditingController username=TextEditingController(text:Myapp.local_storage.getString('username').toString());
  TextEditingController phone=TextEditingController(text:Myapp.local_storage.getString('phone').toString());
  TextEditingController email=TextEditingController(text:Myapp.local_storage.getString('email').toString() );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: Scaffold(body:SafeArea (child:Container(child:Column(children:[
    ExpansionTile(title:Text('Personnel information'),children: [
      GestureDetector (onTap: (){
      BlocProvider.of<AccountCubit>(context).ChangeImage();
      }, child: Container(child: CircleAvatar( radius: 40, backgroundColor:Colors.amber,))),
      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                            controller:username ,
                            decoration: InputDecoration(
                                
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))))),SizedBox(height: 20,),
                                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                            controller:phone ,
                            decoration: InputDecoration(
                                
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))))),
                                    SizedBox(height: 20,),
                                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                            controller:email ,
                            decoration: InputDecoration(
                                
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))))),SizedBox(height: 20,),
                                    MaterialButton(onPressed: (){},child: Text('Upadate'),)
    ],)
        ])))),
    );
  }
}*/