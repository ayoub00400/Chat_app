import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:revision_1/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  dynamic chosenImage=null;
  RegisterCubit() : super(RegisterInitial());

  ChangeImage()async{
    dynamic pic_file;
    chosenImage=await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if(chosenImage==null){

    }else{
      emit(RegistrationImageChanged());
}





    }
  
  SignUpNewUser(String username,String email,String password,String phone){
    emit(RegisterLoading());
    Myapp.fire_auth.createUserWithEmailAndPassword(email:email , password: password).then((value){
      if(chosenImage==null){

         Myapp.fire_cloud_store.collection('users').doc(value.user!.uid.toString()).set({
      
      'username':username,
      'email':email,
      'password':password,
      'phone':phone,
      'profile_image':'https://media.istockphoto.com/photos/renewable-energy-and-sustainable-development-picture-id1186330948?k=20&m=1186330948&s=612x612&w=0&h=5aNPCcQ8FcZraX44PEhb2mqcHkow2xMITJMHdh28xNg=',
      'bio':''
    }).then((value){
      emit(RegisterDone());
    }).catchError((error){
        emit(RegisterFailed());
    });

      }else{
        print(Uri.file( chosenImage.path).pathSegments.last);
      Myapp.FireStorage_obj.ref().child('images/${value.user!.uid.toString()}/'+Uri.file( chosenImage.path).pathSegments.last).putFile(File(chosenImage.path)).then((p0) {
        print('image uploaded');
        p0.ref.getDownloadURL().then((value1){
          print('Image URL OF REGISTERED user is ##> '+value1);
          Myapp.fire_cloud_store.collection('users').doc(value.user!.uid.toString()).set({
      
      'username':username,
      'email':email,
      'password':password,
      'phone':phone,
      'profile_image':value1,
      'bio':''
    }).then((value){
      emit(RegisterDone());
    }).catchError((error){
        emit(RegisterFailed());
    });

    }).catchError((error){
      emit(RegisterFailed());
    });});}});}}