import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/firebase_options.dart';
import 'package:splashscreen/sign_in_screen.dart';
import 'package:splashscreen/sign_up_screen.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     home:  const allscreen(),
    );
  }
}

class allscreen extends StatefulWidget {
  const allscreen({super.key});

  @override
  State<allscreen> createState() => _allscreenState();
}

class _allscreenState extends State<allscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
    child: Padding(padding: EdgeInsetsGeometry.all(16),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Text('WELCOME TO OUR APP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
       SizedBox(height: 20,),
     ElevatedButton(onPressed: (){ Get.to(()=>SignUpScreen() ); },
     
      child: Text('Sign Up',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
            
             SizedBox(height: 20,),
     ElevatedButton(onPressed: (){ Get.to(()=>SignInScreen() ); },
     
      child: Text('Sign In',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))


        ],

    ),
    
    
    ),


       ),


    );
  }
}