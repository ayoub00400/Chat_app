import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:revision_1/main.dart';
import'dart:convert';
import '../../../shared/Local/localstorage.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  
  LoginCubit() : super(LoginInitial());
 
  login(String email, String password){
    emit(LoginProccesed());
    Myapp.fire_auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      Myapp.local_storage.setString('uid',value.user!.uid );
      Myapp.fire_cloud_store.collection('users').doc(value.user!.uid).get().then((data){
        Myapp.local_storage.setString('username',data['username'].toString());
         Myapp.local_storage.setString('phone',data['phone'].toString());
         Myapp.local_storage.setString('bio',data['bio'].toString());
          Myapp.local_storage.setString('email',data['email'].toString());
          Myapp.local_storage.setString('password',data['password'].toString());
          Myapp.local_storage.setString('profile_image',data['profile_image'].toString());
      });
      
      
      emit(LoginSeccess());
    }).catchError((error){
      print("The error is======="+error.toString());
      emit(LoginFailed());
      });

  }
  
}


