import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note_app_adam/screens/home_screen.dart';
import 'package:note_app_adam/screens/login_in_page.dart';

import '../services/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final  formKey  = GlobalKey<FormState>();

  bool isPassword = true;

  var email = TextEditingController();
  var password = TextEditingController();


  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,

                    child: Image.asset(

"assets/logo.png"
                    ),
                  ),
                ),
              ),
              Text("Welcome user !"),
              Text(
                "Please sign up ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller:  email,

                  validator: (value){
                    if(value!.isEmpty){
                      return "please enter your email";
                    }else if (!value.contains("@")){
                      return "Email must contain @";
                    }
                    return null;
                  },




                  decoration: InputDecoration(
                    /// fouced border - error border - disabled border - enabled
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      /// prefix icon - suffix icon
                      prefixIcon: Icon(Icons.alternate_email),
                      labelText: "Email",
                      hintText: "enter your email"
                  )
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,


                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your password";
                    } else if (value.length < 6) {
                      return "Please enter a vaild password";
                    }
                    return null;
                  },
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    /// fouced border - error border - disabled border - enabled
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      /// prefix icon - suffix icon
                      prefixIcon: Icon(Icons.password),
                      labelText: "Password",

                      hintText: "enter your Password",
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isPassword = !isPassword;

                        });
                        /*
                        if (isPassword == true){
                        icon: slash
                        }else{
                        eye
                        }

                        inline if
                        condition ? code if true : code if false
                        isPassword == true ? slash : eye



                        */

                      }, icon: Icon(isPassword == true ? Icons.visibility_off : Icons.remove_red_eye))
                  )
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: (){
                },
                child: Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: Text("Forget Password", style: TextStyle(color: Colors.blue),)),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(250, 50)
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                     bool sucess =    await authService.signUp(email.text, password.text);
                     print(sucess);
                       if(sucess==true){
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                           return HomeScreen();
                         }));
                       }else{
                         ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text("SomeThind is wrong, please try again"))
                         );
                       }
                    }
                  }

                  , child: Text("Sign up")),
              SizedBox(
                height: 15,
              ),
              RichText(text: TextSpan(
                  style: TextStyle(

                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(  text: "Do you have an account ?"),
                    /// GestureDetector --- Inkwell
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = (){

                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return LoginPage();
                        }));

                      },

                      text: "Login", style: TextStyle(
                      color: Colors.blue,

                    )
                      ,
                    )
                  ]



              ))

            ],
          ),
        ),
      ),
    );
  }
}
