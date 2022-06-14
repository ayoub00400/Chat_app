import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/modules/registeration/cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  static String pageName='/registration';
  //const RegisterScreen({Key? key}) : super(key: key);
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body:SingleChildScrollView(
      child: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
             if (state is RegisterDone){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3) , content:Text('Registred Done')));
                Future.delayed(Duration(seconds: 4),()=>Navigator.of(context).pop());
             }else{
               if (state is RegisterFailed){ ScaffoldMessenger.of(context). showSnackBar(SnackBar(  duration: Duration(seconds: 3) , content:Text('Registration Failed try again')));} }
          },
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
               Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0,vertical:20),
                    child: Container(width: double.infinity, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Create new Account',style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold),),SizedBox(height: 5,),
                       Text('Register to discover new friends .',style: TextStyle(color: Colors.grey, fontSize: 20),),
                    ]),),
                  ),SizedBox(height: 20,),
                  Container(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<RegisterCubit,RegisterState>(
                        builder: (context,state) {
                          return Container(height: 100,width: 100, clipBehavior:Clip.antiAliasWithSaveLayer,decoration: BoxDecoration(shape:BoxShape.circle ),child: (BlocProvider.of<RegisterCubit>(context).chosenImage==null)?Image(image: NetworkImage('https://media.istockphoto.com/photos/renewable-energy-and-sustainable-development-picture-id1186330948?k=20&m=1186330948&s=612x612&w=0&h=5aNPCcQ8FcZraX44PEhb2mqcHkow2xMITJMHdh28xNg='),fit: BoxFit.cover):Image(image: FileImage(File(BlocProvider.of<RegisterCubit>(context).chosenImage.path)),fit: BoxFit.cover));
                          //return CircleAvatar(backgroundImage:(BlocProvider.of<RegisterCubit>(context).chosenImage==null)?NetworkImage(''):FileImage(file) Image.file(File(BlocProvider.of<RegisterCubit>(context).chosenImage)));
                        }
                      ),
                       BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return TextButton(onPressed: (){
    
                        BlocProvider.of<RegisterCubit>(context).ChangeImage();
                      }, child:Text('Add picture',style:TextStyle(color:Colors.deepPurple)));})
                    ],
                  )),SizedBox(height: 40,),
              Container(
                  padding: EdgeInsets
                  .symmetric(horizontal: 10),
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
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                      controller: email,
                     // obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Example@mail.com',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))))),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                      controller: phone,
                     // obscureText: true,
                      decoration: InputDecoration(
                          hintText: '+231665756955',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))))),
              SizedBox(
                height: 30,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<RegisterCubit>(context).SignUpNewUser(
                          username.text, email.text, password.text, phone.text);
                    },
                    child: state is RegisterLoading
                        ? CircularProgressIndicator()
                        : Text('SignUP'),
                    style: ElevatedButton.styleFrom(
                      primary:Colors.deepPurple,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  );
                },
              ),
            ],
          )),
        ),
      )),
    );
  }
}
