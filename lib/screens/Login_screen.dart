import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habilae_project/components/my_button.dart';
import 'package:habilae_project/components/my_textfield.dart';
import 'package:habilae_project/screens/Home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName = '';
  var loginType = 'user';
  bool isUser = true;

  bool isLoading = false;

  TextEditingController userNameContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 234, 247),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                const Text(
                  'computerized patient diagnose system on blood anemia.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                isUser
                    ? const Text(
                        'User Login',
                        style: TextStyle(fontSize: 20),
                      )
                    : const Text(
                        'Admin Login',
                        style: TextStyle(fontSize: 20),
                      ),
                MyTextField(
                  controller: userNameContoller,
                  hintText: 'input username',
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is Required";
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]+").hasMatch(value)) {
                      return "Please enter a valid email address";
                    }

                    return null;
                  },
                  onSaved: (value) {
                    userName = value!;
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MyTextField(
                    controller: passwordController,
                    hintText: 'input password',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is Required";
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]+").hasMatch(value)) {
                        return "Please enter a valid password";
                      }

                      return null;
                    },
                    onSaved: (value) {}),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MyButton(
                    onTap: () async {
                      /////////////////////////

                      if (!formKey.currentState!.validate()) {
                        return;
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 4));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      userType: loginType,
                                      userName: userName,
                                    )));
                      }
                      formKey.currentState!.save();
                    },
                    text: isLoading ? 'loading...' : 'login'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isUser = !isUser;
                              if (isUser) {
                                loginType = 'user';
                              } else {
                                loginType = 'admin';
                              }
                            });
                          },
                          child: isUser
                              ? const Text(
                                  'Login as Admin',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 248, 45, 31)),
                                )
                              : const Text('Login as User',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 248, 45, 31)))),
                    ],
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
