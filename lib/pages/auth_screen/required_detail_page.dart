import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swap_store/components/google_map/google_map_page.dart';
import 'package:swap_store/services/authendication_service.dart';
import 'package:swap_store/widgets/custom_elevated_button.dart';
import 'package:swap_store/widgets/custom_textfield.dart';

import '../../model/partner_product_model.dart';

class RequiredDetailPage extends StatefulWidget {
  final File? image;
  final String username;
  final int mobileNumber;
  final String emailAddress;
  final String password;
  const RequiredDetailPage(
      {super.key,
      this.image,
      required this.username,
      required this.mobileNumber,
      required this.emailAddress,
      required this.password});

  @override
  State<RequiredDetailPage> createState() => _RequiredDetailPageState();
}

class _RequiredDetailPageState extends State<RequiredDetailPage> {
  String? selectedCategory;
  //image picker
  File? storeImage;
  final picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? compressedImage = await compressImage(File(pickedFile.path));
      setState(() {
        storeImage = compressedImage;
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
//google map location
  double? latitude;
  double? longitude;
  String address = '';

  String staticMap(double latitude, double longitude) {
    final apiKey = 'AIzaSyCuB8eJT8H1rS7znNWQAtnWUjonMCG8AsQ';
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$apiKey";
  }

  Future<void> requestLocationPermission() async {
    final permission = Permission.location;

    if (await permission.isGranted) {
      getCurrentLocation();
    } else {
      if (await permission.isDenied) {
        await permission.request();
      }

      if (await permission.isPermanentlyDenied) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Location Permission"),
              content: Text(
                  "Location permission is permanently denied. Please enable it in the settings."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                  child: Text("Open Settings"),
                ),
              ],
            );
          },
        );
      } else if (await permission.isGranted) {
        getCurrentLocation();
      }
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    // Check if location services are enabled
    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    // Convert coordinates to address
    _getAddressFromCoordinates(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          address =
              "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        address = "Unable to fetch address.";
      });
    }
  }

  void navigateToMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(),
      ),
    );

    if (result != null) {
      double lat = result['latitude'];
      double lng = result['longitude'];

      // Update the real-time address box
      _getAddressFromCoordinates(lat, lng);
    }
  }

  //class
  final auth = AuthendicationService();
//sumbitbutton
  sumbitbutton() async {
    if (shopNameController.text.isNotEmpty ||
        selectedCategory != null ||
        storeImage != null) {
      Get.snackbar("Error", "Please fill the details");
    } else {
      await auth.createUser(context,
          email: widget.emailAddress, password: widget.password);

      // database code to save the details
    }
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();

    Geolocator.getServiceStatusStream().listen((serviceStatus) {
      if (serviceStatus == geolocator.ServiceStatus.enabled) {
        getCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Store Details",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: size.height * 0.02,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              if (storeImage == null)
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: size.height * 0.20,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2)),
                    child: Center(child: Text("Please select store image")),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(5),
                  height: size.height * 0.20,
                  width: size.width * 1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2),
                      image: DecorationImage(
                          image: FileImage(storeImage!), fit: BoxFit.cover)),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              CustomTextFieldWithoutBorder(
                  text: "Store name", controller: shopNameController),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
                isExpanded: true,
                hint: Text(
                  "Select Category",
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
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              //map location
              if (latitude == null && longitude == null)
                GestureDetector(
                  onTap: navigateToMap,
                  child: SizedBox(
                    height: size.height * 0.20,
                    width: size.width * 1,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                )
              else
                GestureDetector(
                  onTap: navigateToMap,
                  child: Container(
                    height: size.height * 0.20,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          staticMap(latitude!, longitude!),
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                "Address : $address",
              ),

              SizedBox(
                height: size.height * 0.08,
                width: size.width * 1,
                child: CustomElevatedButton(
                    text: "Submit",
                    onPressed: sumbitbutton,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
