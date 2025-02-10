import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap_store/pages/auth_screen/auth_screen.dart';

import '../../constants/constants.dart';
import '../../services/authendication_service.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/profile_page_buttons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool switchButtonValue = false;

  bool? switchButtonOnchanged(value) {
    setState(() {
      switchButtonValue = value;
    });
    return null;
  }

//image picker
  File? image;
  final picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

//class
  final auth = AuthendicationService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(
          height: size.height * 0.10,
        ),
        //profile picture
        (image != null)
            ? Center(
                child: Material(
                  shape: CircleBorder(
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3)),
                  color: Theme.of(context).primaryColor,
                  child: Material(
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.white, width: 4)),
                    child: CircleAvatar(
                      backgroundImage: FileImage(image!),
                      radius: 80,
                    ),
                  ),
                ),
              )
            : Center(
                child: GestureDetector(
                  onTap: getImageFromGallery,
                  child: Material(
                    shape: CircleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 3)),
                    color: Theme.of(context).primaryColor,
                    child: Material(
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.white, width: 4)),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(networkImage),
                        radius: 80,
                      ),
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: size.height * 0.01,
        ),
        // user name
        Text(
          "User Name",
          style: TextStyle(
              color: Color(0xff0B67BC),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1.3,
        ),
        //total credit balance
        Text(
          "245,45",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
        ),
        Text(
          "Wallet Balance",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: size.height * 0.02,
            children: [
              SizedBox(
                height: size.height * 0.10,
                width: size.width * 1,
                child: ProfilePageSwitchButton(
                  text: "Premium User",
                  icon: Icons.power_settings_new,
                  value: switchButtonValue,
                  onChanged: switchButtonOnchanged,
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 1,
                child: ProfilePageButtons(
                  text: "Edit Profile",
                  icon: Icons.edit,
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 1,
                child: ProfilePageButtons(
                  text: "Account Settings",
                  icon: Icons.swap_calls,
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.50,
                child: CustomElevatedButton(
                  text: "Logout",
                  onPressed: () {
                    auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
