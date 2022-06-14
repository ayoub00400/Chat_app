import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  int pageIndex=0;
  
  HomePageCubit() : super(HomePageInitial());

  ChangeAppPage(int index){
    pageIndex=index;
    emit(PageIndexChanged());
  }
  
}
