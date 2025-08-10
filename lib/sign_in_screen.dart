import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/mobilescreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    
    final emailController = TextEditingController();
    final passwordController = TextEditingController();


    Future <void> signUp() async{
  
  final email = emailController.text.trim();
  final password = passwordController.text.trim();


  if (!email.contains('@')) {
    Get.snackbar('Error', 'Invalid email address',
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  if (password.length < 6) {
    Get.snackbar('Error', 'Password must be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

   try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    Get.snackbar('Success', 'Signed in successfully',
       );

    Get.to(() => const Mobilescreen());
  } on FirebaseAuthException catch (e) {
    String message = 'An error occurred';
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided.';
    }
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
  }
}



    return Scaffold(
      appBar: AppBar(title: Text('Sign In'),automaticallyImplyLeading: false,centerTitle: true,),
body: SingleChildScrollView(
  child:Center(
    child: Padding(padding: EdgeInsets.all(25),
    child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [


Container(

decoration: BoxDecoration(
color: Colors.grey.withOpacity(.2),
boxShadow: [BoxShadow(  color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3) ),]


),

child:TextField(
 controller: emailController,
  decoration: const InputDecoration(
                  hintText: "Email",
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  border: InputBorder.none,
                ),
),
),


SizedBox(height: 12,),


Container(

decoration: BoxDecoration(
color: Colors.grey.withOpacity(.2),
boxShadow: [BoxShadow(  color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3) ),]


),

child:TextField(
 controller: passwordController,
  obscureText: isHidden,
        decoration: InputDecoration(
          hintText: "Password",
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              isHidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isHidden = !isHidden; // toggle
              });
            },
          ),
        ),
),
),


SizedBox(height: 18,),

ElevatedButton(
  
style: ElevatedButton.styleFrom(  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),),

  onPressed: (){ signUp();},


 child: Text('Sign In',style: TextStyle(fontSize: 16))),

SizedBox(height: 18,),
 Divider(),

GestureDetector(
  onTap: () {
    Get.to(() => ForgotPasswordPage());  // Replace with your actual page widget
  },
  child: Text(
    'Forgot Password?',
    style: TextStyle(
      color: Colors.blueAccent,
      decoration: TextDecoration.underline, // optional for link style
    ),
  ),
),


],

    ),
    ),
  ),
),

    );
  }
}



  
  class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

          final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendPasswordReset() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent! Check your inbox.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Padding(padding: EdgeInsets.all(20),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [

           TextFormField(
             keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: 'Enter Email',
   
  ),
),
SizedBox(height: 20),
ElevatedButton(
  
  onPressed: _sendPasswordReset,
   child: Text('Send Reset password Link'))





         ],



       ),
       
       
       
       ),

      ),
    );
  }
}