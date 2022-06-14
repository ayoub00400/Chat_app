import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  TextEditingController username_controller =
      TextEditingController(text: Myapp.local_storage.getString('username'));
  TextEditingController phone_controller =
      TextEditingController(text: Myapp.local_storage.getString('phone'));
  TextEditingController bio_controller =
      TextEditingController(text: Myapp.local_storage.getString('bio'));
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AccountCubit(),
        child: BlocListener<AccountCubit, AccountState>(
          listener: (context, state) {
            if(state is UpdateDone){
              Navigator.of(context).pop();
            }else{
              if(state is ProfileImageChanged){}

            }
          },
          child: Scaffold(
              body: SafeArea(
                  child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                    BlocBuilder<AccountCubit, AccountState>(
                        builder: (context, state) {
                      return Container(
                          height: 150,
                          width: 150,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: (BlocProvider.of<AccountCubit>(context)
                                      .pickedImage ==
                                  null)
                              ? Image(
                                  image: NetworkImage(Myapp.local_storage
                                      .getString('profile_image')),
                                  fit: BoxFit.cover)
                              : Image(
                                  image: FileImage(File(
                                      BlocProvider.of<AccountCubit>(context)
                                          .pickedImage
                                          .path)),
                                  fit: BoxFit.cover));
                      //return CircleAvatar(backgroundImage:(BlocProvider.of<RegisterCubit>(context).chosenImage==null)?NetworkImage(''):FileImage(file) Image.file(File(BlocProvider.of<RegisterCubit>(context).chosenImage)));
                    }),
                    BlocBuilder<AccountCubit, AccountState>(
                        builder: (context, state) {
                      return GestureDetector(
                          onTap: () {
                            BlocProvider.of<AccountCubit>(context)
                                .ChangeImage();
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.pinkAccent,
                              child: Icon(Icons.edit)));
                    })
                  ])),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      controller: username_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))))),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      controller: phone_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))))),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: (Myapp.local_storage.getString('bio') == "")
                      ? TextField(
                          controller: bio_controller,
                          decoration: InputDecoration(
                              hintText: 'type bio',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))))
                      : TextField(
                          controller: bio_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))))),
              SizedBox(
                height: 15,
              ),
              BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    if(state is UpdateLoading ){
                      return CircularProgressIndicator();

                    }else{
                return TextButton(
                    onPressed: () {
                      BlocProvider.of<AccountCubit>(context).UpdateUserInfos(
                          username_controller.text,
                          phone_controller.text,
                          bio_controller.text);
                    },
                    child: Text('Save data'));}
              })
            ],
          ))),
        ));
  }
}
