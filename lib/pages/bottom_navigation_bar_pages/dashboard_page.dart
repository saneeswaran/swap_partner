import 'package:flutter/material.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/create_product_page.dart';
import 'package:swap_store/pages/tab_bar_pages/orders_page.dart';
import 'package:swap_store/pages/tab_bar_pages/status_page.dart';
import 'package:swap_store/pages/tab_bar_pages/transaction_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  bool switchOn = false;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 3, vsync: this, animationDuration: Duration(milliseconds: 200))
      ..addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Swap Requests",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        actions: <Widget>[
          Switch(
              value: switchOn,
              activeTrackColor: Color(0xff38D0BE),
              onChanged: (value) {
                setState(() {
                  switchOn = value;
                });
              }),
          SizedBox(
            width: size.width * 0.02,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              indicatorColor: Colors.deepPurpleAccent,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              onTap: (int value) {
                setState(() {
                  tabController.index = value;
                });
              },
              tabs: [
                Tab(
                  text: "Orders",
                ),
                Tab(
                  text: "Transactions",
                ),
                Tab(
                  text: "Status",
                ),
              ],
              controller: tabController,
            ),
          ),
        ),
      ),
      floatingActionButton: tabController.index == 0
          ? FloatingActionButton(
              tooltip: "Click to add products",
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProductPage()));
              },
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )
          : null,
      body: TabBarView(controller: tabController, children: [
        Center(child: OrdersPage()),
        Center(child: TransactionPage()),
        Center(child: StatusPage()),
      ]),
    );
  }
}
