import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:revision_1/modules/chats/chats.dart';
import 'package:revision_1/modules/profile/profile.dart';
import '../modules/contacts/contacts.dart';
import 'cubit/home_page_cubit.dart';

class HomeScreen extends StatefulWidget {
  static String pageName = '/homepage';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> appPages = [Chats(),Contacts(),Profile()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          bottomNavigationBar: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: BlocProvider.of<HomePageCubit>(context).pageIndex,
                unselectedItemColor: Colors.grey[400],
                selectedItemColor: Colors.deepPurple,
                showUnselectedLabels: true
                ,
                items: [
                  BottomNavigationBarItem(
                      label: 'Chats',
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                        Icons.chat,
                      ))),
                  BottomNavigationBarItem(
                      label: 'Contacts', icon:  Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child:Icon(Icons.contact_page))),
                  BottomNavigationBarItem(
                      label: 'Profile', icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(Icons.person))),
                ],
                onTap: (index) => BlocProvider.of<HomePageCubit>(context)
                    .ChangeAppPage(index),
              );
            },
          ),
          body: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              return appPages[
                  BlocProvider.of<HomePageCubit>(context).pageIndex];
            },
          )),
    );
  }
}
