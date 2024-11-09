
import 'package:coral_machine_test/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../components/background_circles.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../constants/constants.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  //text controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmpasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //register method
  void register(BuildContext context) {
    //get auth service
    final auth = AuthService();

    //passwords match  -> create user
    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        auth.signUpWithEmailPassword(
         _emailController.text, _passwordController.text);

      } catch (e) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
    else {
      //passwords don't match -> tell user to fix
      showDialog(
          context: context,
          builder: (context) =>
          const
          AlertDialog(
            title: Text(Constants.registrationErrorText),
          ));
    }


  }


    @override
    Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            const BackgroundCircles(color: Color.fromARGB(255, 179, 58, 49),),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(
                        height: screenHeight * 0.15
                        ),
                      //logo
                      Text(Constants.registerText,
                      style: TextStyle(
                          fontSize: isSmallScreen ? 40 : 50,
                          fontWeight: FontWeight.bold,
                        ),),
                      SizedBox(
                        height: screenHeight * 0.05
                        ),
              
                      //create account message
                       Text(
                        Constants.letsCreateAccountText,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16
                          ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03
                        ),
              
                      //email extfield
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
                      SizedBox(height: screenHeight * 0.02),
              
                      //confirmpassword textfield
                      MyTextField(
                          controller: _confirmpasswordController,
                          hintText: Constants.confirmPassText,
                          obscureText: true),
              
                       SizedBox(height: screenHeight * 0.03),
              
                      //sign- in button
                      MyButton(onTap: ()=>register(context), text: Constants.registerText),
                      SizedBox(
                        height: screenHeight * 0.05
                        ),
              
                      //not a member ? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(Constants.alreadyMemberText,
                          style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: onTap,
                            child:  Text(
                              Constants.loginNowText,
                              style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 14 : 16),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ],
          )
      );

  }

}