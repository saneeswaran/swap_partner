import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swap_store/services/partner_product_provider.dart';

class PartnerProductPage extends StatefulWidget {
  const PartnerProductPage({super.key});

  @override
  State<PartnerProductPage> createState() => _PartnerProductPageState();
}

class _PartnerProductPageState extends State<PartnerProductPage> {
  String selectedButton = "Dining";

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<PartnerProductProvider>(context).getProduct;
    TextStyle customTitleTextStyle =
        TextStyle(fontSize: 16, color: Colors.black);
    TextStyle cutomPriceTextStyle =
        TextStyle(fontSize: 14, color: Colors.black87);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Store Name",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.01,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              //search bar
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: sqrt1_2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: sqrt1_2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: sqrt1_2),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        )),
                  )
                ],
              ),
              //button
              SizedBox(
                height: size.height * 0.10,
                width: size.width * 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: size.width * 0.02,
                    children: [
                      customOutlinedButton("Dining"),
                      customOutlinedButton("Bed"),
                      customOutlinedButton("Wardrobe"),
                      customOutlinedButton("Sofa"),
                    ],
                  ),
                ),
              ),
              //products
              Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                itemCount: product.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: size.height * 0.22,
                              width: size.width * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(product[index].imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              spacing: size.height * 0.01,
                              children: [
                                Text(
                                  product[index].productName,
                                  style: customTitleTextStyle,
                                ),
                                Text(
                                  "Price  : ${product[index].productPrice} ",
                                  style: cutomPriceTextStyle,
                                ),
                                Text(
                                  "Swap Points  : ${product[index].swapPoints}",
                                  style: cutomPriceTextStyle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100),
                                  child: SizedBox(
                                      height: size.height * 0.06,
                                      width: size.width * 0.15,
                                      child: IconButton(
                                          style: IconButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () {},
                                          icon: Center(
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ))),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton customOutlinedButton(String label) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedButton = label;
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: selectedButton == label
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
        backgroundColor: selectedButton == label
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedButton == label
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      ),
    );
  }
}
