import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap_store/constants/constants.dart';
import 'package:swap_store/pages/bottom_nav_bar.dart';
import 'package:swap_store/services/authendication_service.dart';
import 'package:swap_store/widgets/custom_elevated_button.dart';
import 'package:swap_store/widgets/custom_textfield.dart';

import 'required_detail_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //controllers for sign up
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //controllers for login
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool isPassCheck1 = true;
  bool isPassCheck2 = true;
  bool isLogin = false;
  int isSelected = 0;

  //class
  final auth = AuthendicationService();

//image picker
  File? userImage;
  final picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userImage = File(pickedFile.path);
      });
    }
  }

  //remove image
  removeImage() {
    setState(() {
      userImage = null;
    });
  }

  //sign in button function

  void _togglePasswordView() {
    setState(() {
      isPassCheck1 = !isPassCheck1;
    });
  }

  void togglePasswordView() {
    setState(() {
      isPassCheck2 = !isPassCheck2;
    });
  }

  validator() {
    if (emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        userImage == null ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Erroe", "Please fill the details");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appName,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 30),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (widget, animation) => FadeTransition(
                      opacity: animation,
                      child: widget,
                    ),
                    child:
                        isLogin ? buildLoginForm(size) : buildSignUpForm(size),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: isLogin
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTabButton("Create Account", !isLogin),
                            _buildTabButton("Log In", isLogin),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = (text == "Log In");
          });
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpForm(Size size) {
    return Container(
      key: ValueKey(1),
      child: Column(
        spacing: size.height * 0.02,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (userImage == null)
            GestureDetector(
              onTap: getImageFromGallery,
              child: Container(
                height: size.height * 0.20,
                width: size.width * 0.40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(emptyImage), fit: BoxFit.cover),
                ),
              ),
            )
          else
            Container(
              height: size.height * 0.20,
              width: size.width * 0.40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FileImage(userImage!), fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    child: IconButton(
                        onPressed: removeImage,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))),
              ),
            ),
          CustomTextfield(
            text: "User Name",
            controller: usernameController,
          ),
          CustomTextfield(
            text: "Email",
            controller: emailController,
          ),
          CustomTextfield(
            text: "Phone",
            controller: phoneController,
            keyboardType: TextInputType.number,
            maxLength: 10,
          ),
          CustomTextfield(
            text: "Password",
            icon: isPassCheck1 ? Icons.visibility : Icons.visibility_off,
            obScure: isPassCheck1,
            onPressed: _togglePasswordView,
            controller: passwordController,
          ),
          CustomTextfield(
            text: "Confirm Password",
            icon: isPassCheck2 ? Icons.visibility : Icons.visibility_off,
            obScure: isPassCheck2,
            onPressed: togglePasswordView,
            controller: confirmPasswordController,
          ),
          SizedBox(
            height: size.height * 0.07,
            width: size.width * 0.50,
            child: CustomElevatedButton(
                text: "Sign Up",
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      usernameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      userImage == null ||
                      confirmPasswordController.text.isEmpty) {
                    Get.snackbar("Error", "Please fill the details");
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    Get.snackbar("Error", "The password does not match");
                  } else if (userImage == null) {
                    Get.snackbar("Error", "Please select an image");
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequiredDetailPage(
                                  username: usernameController.text,
                                  emailAddress: emailController.text.trim(),
                                  mobileNumber: int.parse(phoneController.text),
                                  password: passwordController.text,
                                  image: userImage,
                                )));
                  }
                },
                color: buttonColor),
          ),
          SizedBox(
            height: size.height * 0.02,
          )
        ],
      ),
    );
  }

  // Login Form
  Widget buildLoginForm(Size size) {
    return Container(
      key: ValueKey(2),
      child: Column(
        spacing: size.height * 0.02,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextfield(
            text: "Email",
            controller: loginEmailController,
          ),
          CustomTextfield(
            text: "Password",
            icon: isPassCheck1 ? Icons.visibility : Icons.visibility_off,
            obScure: isPassCheck1,
            onPressed: _togglePasswordView,
            controller: loginPasswordController,
          ),
          SizedBox(
            height: size.height * 0.07,
            width: size.width * 0.50,
            child: CustomElevatedButton(
                text: "Login",
                onPressed: () {
                  auth.loginUser(context,
                      email: loginEmailController.text,
                      password: loginPasswordController.text);

                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar()));
                  }
                },
                color: buttonColor),
          ),
          SizedBox(
            height: size.height * 0.02,
          )
        ],
      ),
    );
  }
}
