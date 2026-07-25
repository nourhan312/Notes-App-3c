import 'package:flutter/material.dart';
import 'package:note_app_adam/services/cache_helper.dart';
import 'package:note_app_adam/screens/home_screen.dart';
import 'package:note_app_adam/screens/login_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

 CacheHelper cacheHelper = CacheHelper();
  @override
   initState()  {
    super.initState();
    goToScreen();
  }

  void goToScreen() async{
    await Future.delayed(Duration(seconds: 3));
     bool isUserLogin = await cacheHelper.getBool("isLogin");

     if(isUserLogin== true){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
         return HomeScreen();
       }));
     }

     else{
Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
return LoginPage();
}));
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/logo.png"))),
    );
  }
}
