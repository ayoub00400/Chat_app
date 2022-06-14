import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/layout/homelayout.dart';
import 'package:revision_1/modules/login/cubit/login_cubit.dart';
import 'package:revision_1/modules/registeration/registration.dart';

class LoginScreen extends StatelessWidget {
  static String pageName = '/login';
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  //const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {

           
                if(state is LoginSeccess ){
                  Navigator.of(context).pushReplacementNamed(HomeScreen.pageName);
                }else{
                   if(state is LoginProccesed ){
                     showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Login Loading'),content: Center(child: CircularProgressIndicator()),));
                   }else{
                  showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Login Failed'),));
                }}
 // TODO: implement listener
            },
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0,vertical:20),
                  child: Container(width: double.infinity, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Login',style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold),),SizedBox(height: 10,),
                     Text('Please sign in to continue.',style: TextStyle(color: Colors.grey, fontSize: 20),),
                  ]),),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: username,
                        decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))))),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(

                                  onPressed: () async {
                                    BlocProvider.of<LoginCubit>(context).login(username.text, password.text);
                                  },
                                  child: Text('Login',style: TextStyle(fontSize: 20, color:Colors.white,),),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.purple,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5, horizontal: 10)),

                                );
                  },
                ),SizedBox(
                  height: 40,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('If you have an account you can '),
                    TextButton(onPressed: (){
Navigator.of(context).pushNamed(RegisterScreen.pageName);
                    }, child: Text('Register',style: TextStyle(fontSize: 16, color: Colors.purpleAccent),)),
                  ],
                )

              ],
            )),
          )),
    );
  }
}
