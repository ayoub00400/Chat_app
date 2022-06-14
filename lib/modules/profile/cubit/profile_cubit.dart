import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:revision_1/main.dart';
import 'package:revision_1/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserTamplate? my_app_user = null;
  ProfileCubit() : super(ProfileInitial());
  LoadProfileInfos() {
    emit(ProfileInfosLoading());
    my_app_user = UserTamplate(
        Myapp.local_storage.getString('username'),
        Myapp.local_storage.getString('email'),
        Myapp.local_storage.getString('phone'),
        Myapp.local_storage.getString('bio'),
        Myapp.local_storage.getString('profile_image'),
        );
        print(Myapp.local_storage.getString('username'));
        emit(ProfileInfosLoaded());
  }
  
}
