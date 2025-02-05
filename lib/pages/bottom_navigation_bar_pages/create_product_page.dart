import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap_store/widgets/custom_elevated_button.dart';
import 'package:swap_store/widgets/custom_textfield.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  //controller
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productSwapPointController =
      TextEditingController();

  //category
  List<String> categories = [
    "Electronics",
    "Clothing",
    "Books",
    "Home Appliances"
  ];
  String? selectedCategory;
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

  //empty image
  void emptyImage() {
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.02,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Create Product",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Fill out the information below to post a product"),
              if (image == null)
                GestureDetector(
                  onTap: getImageFromGallery,
                  child: Container(
                    height: size.height * 0.30,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("Please select the image"),
                    ),
                  ),
                )
              else
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  height: size.height * 0.30,
                  width: size.width * 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: FileImage(image!), fit: BoxFit.cover)),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                        onPressed: emptyImage,
                        icon: Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.white,
                        )),
                  ),
                ),
              Text(
                "Category",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              //drop down
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  isExpanded: true,
                  hint: Text(
                    "Select Category",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(color: Colors.black45),
                      ),
                    );
                  }).toList(),
                ),
              ),

              //title
              CustomTextfield(
                  text: "Product Title", controller: productTitleController),
              Row(
                children: [
                  Expanded(child: Text("Price")),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Expanded(child: Text("Credit points")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextfield(
                        text: "Price", controller: productPriceController),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Expanded(
                    child: CustomTextfield(
                        text: "Credit Point",
                        controller: productSwapPointController),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 1,
                  child: CustomElevatedButton(
                      text: "Create Product",
                      onPressed: () {
                        if (categories.isEmpty ||
                            image == null ||
                            productPriceController.text.isEmpty ||
                            productTitleController.text.isEmpty ||
                            productSwapPointController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please fill in all the details")));
                        } else {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      },
                      color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
