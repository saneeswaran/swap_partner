import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/custom_elevated_button.dart';

class CustomerProductPage extends StatelessWidget {
  final int productId;
  const CustomerProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle customTextStyle = TextStyle(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w400);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Store Name",
          style: TextStyle(
              color: secondaryColor, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.04,
            children: [
              //category and sid number
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Appliances",
                    style: customTextStyle,
                  ),
                  Text(
                    "SID : 1124",
                    style: customTextStyle,
                  ),
                ],
              ),

              //image
              Container(
                height: size.height * 0.20,
                width: size.width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    )),
                child: Center(
                  child: Text("Redeemed Image"),
                ),
              ),
              Text("Item Name :", style: customTextStyle),
              Text("Item Description :", style: customTextStyle),

              //location and date
              Text("Product Age :", style: customTextStyle),
              Text("Product Purchase Price :", style: customTextStyle),
              Text("Area :", style: customTextStyle),
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 1,
                child: CustomElevatedButton(
                  text: "Share Redeem Product",
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
