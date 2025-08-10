import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/mobilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override

  bool isHidden = true;
  @override
  Widget build(BuildContext context) {

    final nameController =TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

Future<void> signUp() async {
  final name = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (name.isEmpty) {
    Get.snackbar('Error', 'Please enter your name');
    return;
  }

  if (!email.contains('@')) {
    Get.snackbar('Error', 'Invalid email address');
    return;
  }

  if (password.length < 6) {
    Get.snackbar('Error', 'Password must be at least 6 characters');
    return;
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    
    await userCredential.user!.updateDisplayName(name);

    Get.snackbar('Success', 'Account created successfully');

    Get.to(() => const Mobilescreen());
  } on FirebaseAuthException catch (e) {
    String message = 'An error occurred';
    if (e.code == 'email-already-in-use') {
      message = 'Email already in use';
    } else if (e.code == 'weak-password') {
      message = 'Password is too weak';
    } else if (e.code == 'invalid-email') {
      message = 'Invalid email address';
    }
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
  }
}


    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),automaticallyImplyLeading: false,centerTitle: true,),
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
 controller: nameController,
  decoration: const InputDecoration(
                  hintText: "Name",
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


 child: Text('Sign UP',style: TextStyle(fontSize: 16)))


],

    ),
    ),
  ),
),

    );
  }
}