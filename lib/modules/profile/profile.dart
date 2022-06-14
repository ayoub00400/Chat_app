import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_1/layout/cubit/home_page_cubit.dart';
import 'package:revision_1/main.dart';
import 'package:revision_1/modules/login/login.dart';
import 'package:revision_1/modules/profile/account.dart';
import 'package:revision_1/modules/profile/cubit/profile_cubit.dart';

import '../../shared/componants/componants.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController feedBackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: BlocProvider(
        create: (context) => ProfileCubit()..LoadProfileInfos(),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    
                    Text(
                      'Profile',
                      style: TextStyle(
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontSize: 30),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )),
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: BlocBuilder<ProfileCubit,ProfileState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          
                          radius: 30,
                          backgroundImage:   NetworkImage(BlocProvider.of<ProfileCubit>(context).my_app_user!.profile_image,),
                        );
                      },
                    ),
                              ),
                              Container(
                                width: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<ProfileCubit, ProfileState>(
                                      builder: (context, state) {
                                        return Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            BlocProvider.of<ProfileCubit>(
                                                    context)
                                                .my_app_user!
                                                .username,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    BlocBuilder<ProfileCubit, ProfileState>(
                                      builder: (context, state) {
                                        return Text(
                                          BlocProvider.of<ProfileCubit>(context)
                                              .my_app_user!
                                              .bio,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey,
                              indent: 10,
                              endIndent: 10,
                              height: 40,
                              thickness: 2,
                            ),
                            BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, state) {
                                return ProfileItemBuilder(
                                    context,
                                    'Account',
                                    "Name,City,Phone",
                                    Icons.person_outline,
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.grey,
                                    ), () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              AccountScreen()))
                                      .then((value) =>
                                          BlocProvider.of<ProfileCubit>(context)
                                              .LoadProfileInfos());
                                });
                              },
                            ),
                            ProfileItemBuilder(
                                context,
                                'Notification',
                                "",
                                Icons.notifications_none,
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey,
                                ),
                                () {}),
                            ProfileItemBuilder(
                                context,
                                'Privacy and Terms',
                                "",
                                Icons.lock_outline,
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey,
                                ), () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: SingleChildScrollView(
                                            child: Text(
                                                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,')),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'))
                                        ],
                                      ));
                            }),
                            ProfileItemBuilder(
                                context,
                                'Feedback',
                                "",
                                Icons.help_outline,
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey,
                                ),
                                () => showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          alignment: Alignment.center,
                                          title: Text('Report Feedback'),
                                          children: [
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: TextField(
                                                    maxLines: 4,
                                                    controller:
                                                        feedBackController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Write here .....',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))))),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      if (feedBackController
                                                          .text.isNotEmpty) {
                                                        Myapp.fire_cloud_store
                                                            .collection(
                                                                'feedbackes')
                                                            .doc(Myapp
                                                                .local_storage
                                                                .getString(
                                                                    'uid'))
                                                            .set({
                                                          'userfeedback':
                                                              feedBackController
                                                                  .text
                                                        }).then((value) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          feedBackController
                                                              .text = '';
                                                        });
                                                      } else {}
                                                    },
                                                    child: Text('Send')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Cancel')),
                                              ],
                                            )
                                          ],
                                        ))),
                            ProfileItemBuilder(
                                context,
                                'Logout',
                                "tap to logout",
                                Icons.logout_outlined,
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey,
                                ), () {
                              Myapp.local_storage.remove('uid').then((val) {
                                BlocProvider.of<HomePageCubit>(context)
                                    .ChangeAppPage(0);
                                Navigator.of(context)
                                    .popAndPushNamed(LoginScreen.pageName);
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                  ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
