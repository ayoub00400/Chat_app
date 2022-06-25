import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/modules/Search/search.dart';
import 'package:revision_1/modules/chats/chatscreen.dart';
import 'package:revision_1/modules/chats/cubit/chats_cubit.dart';
import 'package:revision_1/modules/login/login.dart';
import 'package:revision_1/modules/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:revision_1/modules/registeration/registration.dart';
import 'layout/cubit/home_page_cubit.dart';
import 'layout/homelayout.dart';
import 'shared/Local/localstorage.dart';
import 'modules/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("hadi terminated notification");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  //const name({Key? key}) : super(key: key);
  static FirebaseAuth fire_auth = FirebaseAuth.instance;
  static FirebaseFirestore fire_cloud_store = FirebaseFirestore.instance;
  static FirebaseStorage FireStorage_obj=FirebaseStorage.instance ;
  static dynamic local_storage;
  var notifInstatence=FirebaseMessaging.instance;
  @override
  
  Widget build(BuildContext context) {
    notifInstatence.getToken().then((value) => print('token is =>'+value.toString()));

    FirebaseMessaging.onMessage.listen((event) {
      print('ahaaaw rani khadama we hay jatni notif');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('hello from backagrounded app chatify  ');
    }) ;
    
    return FutureBuilder<dynamic>(
        future: LocalStorage.InitLocalStorage(),
        builder: (context, snapshot) {
          local_storage = snapshot.data;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => HomePageCubit()),
              BlocProvider(create: (context) => ProfileCubit()),
              BlocProvider(create: (context) => ChatsCubit()),
            ],
            
            child: BlocBuilder<ProfileCubit,ProfileState>(
              builder: (context,state) {
                return MaterialApp(
                  
                  darkTheme: ThemeData(
                    primaryColor: Colors.deepPurple,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                          backgroundColor: Colors.deepPurple),
                      iconTheme: IconThemeData(color: Colors.white),
                      bottomAppBarColor: Color.fromARGB(252, 53, 52, 52)),
                  theme: ThemeData(
                      bottomAppBarColor: Colors.white,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                          backgroundColor: Colors.deepPurple),
                      primaryColor: Colors.deepPurple),
                  debugShowCheckedModeBanner: false,
                  initialRoute: SplashScreen.pageName,
                  routes: {
                    SplashScreen.pageName: (context) => SplashScreen(),
                    HomeScreen.pageName: (context) => HomeScreen(),
                    LoginScreen.pageName: (context) => LoginScreen(),
                    RegisterScreen.pageName: (context) => RegisterScreen(),
                    ChatScreen.pageName: (context) => ChatScreen(),
                    SearchScreen.pageName: (context) => SearchScreen(),
                  },
                );
              }
            ),
          );
        });
  }
}
