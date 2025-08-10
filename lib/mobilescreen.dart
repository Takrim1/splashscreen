import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Mobilescreen extends StatefulWidget {
  const Mobilescreen({super.key});

  @override
  State<Mobilescreen> createState() => _MobilescreenState();
}

class _MobilescreenState extends State<Mobilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(
        child:SingleChildScrollView(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 350,
            height: 400,
            padding: const EdgeInsets.all(20),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Lottie.asset(
      'assets/Dancecat.json',
      fit: BoxFit.contain,
      repeat: true,
    ),
    SizedBox(height: 10),
    Text(
      'AM I Hired?',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ],
),

          ),
        ),
        )
      ),

    
    );
  }
}