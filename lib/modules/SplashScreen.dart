import 'dart:async';

import 'package:flutter/material.dart';
import 'package:revision_1/modules/login/login.dart';

import '../layout/homelayout.dart';
import '../main.dart';
import '../shared/Local/localstorage.dart';

class SplashScreen extends StatefulWidget {
  // SplashScreen({Key? key}) : super(key: key);
  static String pageName = '/SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
      if(Myapp.local_storage.getString('uid')==null){
         Future.delayed(Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(LoginScreen.pageName));

      }else{
          Future.delayed(Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(HomeScreen.pageName));

      }
    }
    
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                Padding(
                  padding: const EdgeInsets.only(top:15,bottom: 20),
                  child: Text(
                    'Chatify',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Massaging app',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ])),
    );
  }
}