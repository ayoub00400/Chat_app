import 'package:dio/dio.dart';
class DioHelper {
 static final Dio my_http1=Dio() ;
 static final String baseUrl='https://fcm.googleapis.com/fcm/send';
DioHelper();


static PostNotification(String msg)  {
   my_http1.post( baseUrl,options: Options(headers: {
    "Authorization":"key=here enter your cloud messaging server key",
    "Content-Type":"application/json"
  }), data:{
    
      "to":"ci_XgvMmRzKc4atrveXw7m:APA91bGmX3SIU7bDwJcafYiR6wRyQC_xViz3s4D6AL2l1vd2oKBKkuKihM6_EDMY1Cd_h4fOV5MlAyjUD5VQJrrB-O2x_HgmaKj1olefMh_P3f0qLEzPUO1tryjjMigVR5ZZoSGSCNev",
    "notification":{
        "title":"MotherFucker","body":msg,
        "image":"https://www.decorilla.com/online-decorating/wp-content/uploads/2020/09/Dark-and-dramatic-botanical-wallpaper-idea.jpg",
        "color":"#332211",
         
       
    }
  }).then((value) => print('notif ray raht lmoulaha'));
}

}
