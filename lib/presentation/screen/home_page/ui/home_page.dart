import 'package:faq_app/common/constants.dart';
import 'package:faq_app/di/dependency.dart';
import 'package:faq_app/presentation/screen/faq_list/provider/faq_list_notifier.dart';
import 'package:faq_app/presentation/screen/faq_list/ui/faq_list_screen.dart';
import 'package:faq_app/presentation/screen/home_page/provider/home_notifier.dart';
import 'package:faq_app/presentation/screen/profile/provider/profile_notifier.dart';
import 'package:faq_app/presentation/screen/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home-page";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      ChangeNotifierProvider(
          create: (_) => FaqListNotifier(fetchFaqListUseCase: locator()),
          child: const FaqListScreen()),
      ChangeNotifierProvider(
          create: (_) => ProfileNotifier(getUserDataUseCase: locator()),
          child: const ProfileScreen()),
    ];

    List<BottomNavigationBarItem> bottomNavList = [
      const BottomNavigationBarItem(
          label: "FAQ",
          icon: Icon(
            Icons.list,
            size: 26.0,
          )),
      const BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(
            Icons.account_circle,
            size: 26.0,
          ))
    ];

    return Consumer<HomeNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: value.selectedIndex,
              selectedFontSize: 14.0,
              unselectedFontSize: 14.0,
              selectedLabelStyle: kTextSmallNormal,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey.shade700,
              unselectedLabelStyle: kTextSmallNormal,
              onTap: (index) {
                value.setSelectedIndex(index);
              },
              items: bottomNavList),
          body: Scaffold(
            body: pageList[value.selectedIndex],
          ),
        );
      },
    );
  }
}
