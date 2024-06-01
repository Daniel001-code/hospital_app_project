import 'package:flutter/material.dart';
import 'package:habilae_project/screens/Login_screen.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  void goToLogin() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void initState() {
    goToLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 234, 247),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/medical.png'), fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
