import 'package:coral_machine_test/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../pages/settings_page.dart';
import '../services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              //logo
              children: [
                const DrawerHeader(
                    child: Center(
                  child: Text(Constants.appTitle,style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),)
                )),

                //home list tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text(Constants.homeText),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      //pop the drawer
                      Navigator.pop(context);

                    },
                  ),
                ),

                //setting list tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text(Constants.settingsText),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      //pop the drawer
                      Navigator.pop(context);

                      //navigate to settings page
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsPage()));
                    },
                  ),
                ),

                //logout list tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text(Constants.logoutText),
                    leading: const Icon(Icons.logout),
                    onTap: logout,
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}