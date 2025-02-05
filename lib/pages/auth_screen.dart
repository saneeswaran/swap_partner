import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swap_store/constants/constants.dart';
import 'package:swap_store/pages/bottom_nav_bar.dart';
import 'package:swap_store/services/authendication_service.dart';
import 'package:swap_store/widgets/custom_elevated_button.dart';
import 'package:swap_store/widgets/custom_textfield.dart';

import '../services/database_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //controllers for sign up
  TextEditingController storeNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //controllers for login
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool isPassCheck1 = false;
  bool isPassCheck2 = false;
  bool isLogin = false;
  int isSelected = 0;

  //class
  final auth = AuthendicationService();
  final db = DatabaseService();

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  child: isLogin ? buildLoginForm(size) : buildSignUpForm(size),
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
          CustomTextfield(
            text: "Store Name",
            controller: storeNameController,
          ),
          CustomTextfield(
            text: "Email",
            controller: emailController,
          ),
          CustomTextfield(
            text: "Phone",
            controller: phoneController,
          ),
          CustomTextfield(
            text: "Category",
            controller: categoryController,
          ),
          CustomTextfield(
            text: "Location",
            controller: locationController,
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
                onPressed: () async {
                  if (storeNameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      categoryController.text.isEmpty ||
                      locationController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all the fields")));
                  }

                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Passwords do not match")),
                    );
                  }
                  if (passwordController.text.length < 8) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "The password must be at least 8 characters long")));
                  }
                  try {
                    await auth.createUser(context,
                        email: emailController.text,
                        password: passwordController.text);
                    User? user = FirebaseAuth.instance.currentUser;

                    final currentContext = context;
                    await db.createData(currentContext,
                        storeName: storeNameController.text,
                        phoneNumber: int.parse(phoneController.text),
                        category: categoryController.text,
                        location: locationController.text);
                    if (!mounted) return;
                    if (user != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
                    }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
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
                onPressed: () async {
                  await auth.loginUser(context,
                      email: loginEmailController.text,
                      password: loginEmailController.text);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
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
