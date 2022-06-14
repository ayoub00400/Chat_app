import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:revision_1/main.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  dynamic pickedImage;
  AccountCubit() : super(AccountInitial());
  ChangeImage()async{
    dynamic pic_file;
    pickedImage=await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if(pickedImage==null){

    }else{
      emit(ProfileImageChanged());
}
  
  }
  UpdateUserInfos(String username,String phone,String bio){
    emit(UpdateLoading());

if(pickedImage==null){

         Myapp.fire_cloud_store.collection('users').doc(Myapp.local_storage.getString('uid')).update({
      
      'username':username,
    
      
      'phone':phone,
      'profile_image':Myapp.local_storage.getString('profile_image'),
      'bio':bio
    }).then((value){
      Myapp.local_storage.setString('username',username);
      Myapp.local_storage.setString('phone',phone);
      Myapp.local_storage.setString('bio',bio);
      Myapp.local_storage.setString('profile_image',Myapp.local_storage.getString('profile_image'));

      emit(UpdateDone());
    }).catchError((error){
        emit(UpdateFailed());
    });

      }else{
        print(Uri.file( pickedImage.path).pathSegments.last);
      Myapp.FireStorage_obj.ref().child('images/${Myapp.local_storage.getString('uid')}/'+Uri.file( pickedImage.path).pathSegments.last).putFile(File(pickedImage.path)).then((p0) {
        print('image uploaded');
        p0.ref.getDownloadURL().then((value1){
          print('Image URL OF REGISTERED user is ##> '+value1);
          Myapp.fire_cloud_store.collection('users').doc(Myapp.local_storage.getString('uid')).update({
      
      'username':username,
      'phone':phone,
      'profile_image':value1,
      'bio':bio
    }).then((value){
       Myapp.local_storage.setString('username',username);
      Myapp.local_storage.setString('phone',phone);
      Myapp.local_storage.setString('bio',bio);
      Myapp.local_storage.setString('profile_image',value1);
      emit(UpdateDone());
    }).catchError((error){
        emit(UpdateFailed());
    });

    }).catchError((error){
      emit(UpdateFailed());
    });});}





  }
  
  
  }
