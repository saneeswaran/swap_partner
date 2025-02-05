import 'package:flutter/material.dart';
import 'package:swap_store/constants/constants.dart';
import 'package:swap_store/widgets/custom_elevated_button.dart';

class RedeemedPage extends StatelessWidget {
  const RedeemedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle customTextStyle = TextStyle(
        color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400);
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
            spacing: size.height * 0.02,
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
              // price and pointd
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("Points :", style: customTextStyle)),
                  Expanded(child: Text("Price :", style: customTextStyle)),
                ],
              ),
              //location and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("location :", style: customTextStyle)),
                  Expanded(child: Text("Date : :", style: customTextStyle)),
                ],
              ),
              //order id
              Text(
                "Order ID : ",
                style: customTextStyle,
              ),
              Text(
                "Customer Details : ",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              //details of customer
              Text("Name :", style: customTextStyle),
              Text("Contact :", style: customTextStyle),
              Text("Area :", style: customTextStyle),
              Text("Product ID :", style: customTextStyle),
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 1,
                child: CustomElevatedButton(
                  text: "Complete Order",
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
