import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/presentation/components/button/red_background_button.dart';
import 'package:faq_app/presentation/screen/authentication/ui/login_page.dart';
import 'package:faq_app/presentation/screen/profile/provider/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileNotifier>(context, listen: false).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: Consumer<ProfileNotifier>(
            builder: (context, value, child) {
              if (value.logoutState == RequestState.loaded) {
                Future.microtask(() {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                });
              }
              return Column(
                children: [
                  _profileData(context, value),
                  _logoutButton(value),
                ],
              );
            },
          )),
    );
  }

  Padding _logoutButton(ProfileNotifier value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RedBackgroundButton(
        label: "Logout",
        onPressed: () {
          value.logoutUser();
        },
      ),
    );
  }

  Stack _profileData(BuildContext context, ProfileNotifier value) {
    return Stack(
      children: [
        SizedBox(
          height: 280.0,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              value.userData?.data?.pathFoto ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    value.userData?.data?.name ?? "",
                    style: kHeading6,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    value.userData?.data?.email ?? "",
                    style:
                        kTextSmallNormal.copyWith(color: Colors.grey.shade600),
                  ),
                  Text(
                    value.userData?.data?.level ?? "",
                    style: kTextMediumBold,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
