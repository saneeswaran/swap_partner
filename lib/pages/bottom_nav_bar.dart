import 'package:flutter/material.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/dashboard_page.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/history_page.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/partner_product_page.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/profile_page.dart';
import 'package:swap_store/pages/bottom_navigation_bar_pages/scanner_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  List<String> bottomNavBarItemName = [
    "Home",
    "List",
    "Scanner",
    "SOmething",
    "Person"
  ];
  List<Widget> bottomNavBarIcons = [
    Icon(Icons.home),
    Icon(Icons.list),
    Icon(Icons.qr_code_scanner),
    Icon(Icons.history),
    Icon(Icons.person),
  ];
  List<Widget> pages = [
    DashboardPage(),
    PartnerProductPage(),
    ScannerPage(),
    HistoryPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        items: List.generate(
            bottomNavBarIcons.length,
            (index) => BottomNavigationBarItem(
                icon: bottomNavBarIcons[index],
                label: bottomNavBarItemName[index])),
      ),
      body: pages[currentIndex],
    );
  }
}
