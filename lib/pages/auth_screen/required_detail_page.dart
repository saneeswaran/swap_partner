import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swap_store/widgets/custom_textfield.dart';

class RequiredDetailPage extends StatefulWidget {
  const RequiredDetailPage({super.key});

  @override
  State<RequiredDetailPage> createState() => _RequiredDetailPageState();
}

class _RequiredDetailPageState extends State<RequiredDetailPage> {
  //image picker
  File? image;
  final picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? compressedImage = await compressImage(File(pickedFile.path));
      setState(() {
        image = compressedImage;
      });
    }
  }

  Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = "${dir.absolute.path}/compressed.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 70, // Compression Quality
    );

    return result != null ? File(result.path) : null;
  }

//controllers
  final shopNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: size.height * 0.02,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                  child: CircleAvatar(
                radius: 70,
              )),
              CustomTextfield(text: "Shop name", controller: shopNameController)
            ],
          ),
        ),
      ),
    );
  }
}
