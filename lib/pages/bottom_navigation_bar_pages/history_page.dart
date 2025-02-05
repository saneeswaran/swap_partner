import 'package:flutter/material.dart';
import 'package:swap_store/constants/constants.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/redeemed_page.dart';
import 'package:swap_store/widgets/custom_textfield.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //controller
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: size.height * 0.01,
            children: [
          SizedBox(height: size.height * 0.06),
          Center(
            child: Text(
              "Redeem Credits",
              style: TextStyle(
                  color: secondaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              "Total Redeemded",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
          ),
          Center(
            child: Text(
              "13000",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 2,
            thickness: 2,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Products : ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: CustomTextfield(
                        text: "Search",
                        controller: searchController,
                        icon: Icons.search,
                        color: secondaryColor,
                      ),
                    )
                  ],
                ),
                ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            //image
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: secondaryColor, width: 3),
                                    image: DecorationImage(
                                        image: NetworkImage(networkImage),
                                        fit: BoxFit.cover),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              margin:
                                  const EdgeInsets.only(top: 25, bottom: 20),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: size.height * 0.01,
                                    children: [
                                      Text(
                                        "A to Z Furniture",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "product name",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RedeemedPage()));
                            },
                            icon: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            )),
                      );
                    })
              ],
            ),
          )
        ]));
  }
}
