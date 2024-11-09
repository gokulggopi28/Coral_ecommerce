
import 'package:coral_machine_test/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../components/background_circles.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../constants/constants.dart';
import '../services/auth/auth_service.dart';

class Loginpage extends StatefulWidget {
  final void Function()? onTap;

  const Loginpage({super.key, required this.onTap});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //login method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
    }

    //catch error
    catch(e){
      
      // ignore: use_build_context_synchronously
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),));

    }


  }

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
         const BackgroundCircles(color: Colors.blue,),
          SafeArea(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                     height: screenHeight * 0.05,
                    ),
                     Text(Constants.loginText,
                    style: TextStyle(
                          fontSize: isSmallScreen ? 40 : 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
        
                    //welcome back message
                     Text(
                      Constants.welcomeBackText,
                     style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                    ),

                     SizedBox(height: screenHeight * 0.03),
        
                    //email textfield
                    MyTextField(
                        controller: _emailController,
                        hintText: Constants.emailText,
                        obscureText: false),
        
                     SizedBox(
                      height: screenHeight * 0.02
                      ),
        
                    //password textfield
        
                    MyTextField(
                        controller: _passwordController,
                        hintText: Constants.passwordText,
                        obscureText: true),
        
                     SizedBox(
                      height: screenHeight * 0.03
                      ),
        
                    //sign- in button
                    MyButton(onTap: ()=>login(context), text: Constants.loginText),
                     SizedBox(
                      height: screenHeight * 0.05
                      ),
        
                    //not a member ? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Constants.notMemberText,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                              )),
                        const SizedBox(width: 4,),
        
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(Constants.registerNowText, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 14 : 16,
                          ),),
                        ),
                      ],)
                  ],
                ),
              ),
            ),
          ),
        ),
        ])
    );
  }
}