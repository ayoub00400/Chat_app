import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/modules/Search/cubit/search_cubit.dart';
import 'package:revision_1/shared/componants/componants.dart';

class SearchScreen extends StatelessWidget {
  static String pageName = 'SearchScreen';
  //const SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return TextField(
                          onSubmitted: (value) {
                            BlocProvider.of<SearchCubit>(context)
                                .Search(searchText.text);
                          },
                          controller: searchText,
                          decoration: InputDecoration(
                              hintText: 'Search here',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))));
                    },
                  )),
              BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
                if (BlocProvider.of<SearchCubit>(context).searchResult ==
                    null) {
                  return Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Search for Friends',
                      style: TextStyle(fontSize: 26, color: Colors.grey),
                    ),
                  ));
                } else {
                  if (BlocProvider.of<SearchCubit>(context)
                      .searchResult!
                      .isEmpty) {
                    return Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'No related results.',
                        style: TextStyle(fontSize: 26, color: Colors.grey),
                      ),
                    ));
                  } else {
                    return Expanded(
                      child: Container(
                        
                        width: double.infinity,
                        child:ListView(children: BlocProvider.of<SearchCubit>(context).searchResult!.map((e) =>SearcheItemBuilder(context,e)).toList()),
                      ),
                    );
                  }
                }
              })
            ],
          )),
        ));
  }
}
