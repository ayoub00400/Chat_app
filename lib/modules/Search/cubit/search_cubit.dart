import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:revision_1/main.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? searchResult=null;
  SearchCubit() : super(SearchInitial());
  Search(String searchTerm){
    searchResult=[];
    emit(SearchLoading());
     Myapp.fire_cloud_store.collection('users').where('username',isEqualTo: searchTerm).get().then((value) {

      searchResult=value.docs;
      print(searchResult.toString()+'kajj');
      emit(SearchDone());
     } ).catchError((error)=>emit(SearchError()));
  }
}
