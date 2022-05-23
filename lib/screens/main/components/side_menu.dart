import 'package:admin/viewmodels/main_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        primary: false,
        children: [
          DrawerHeader(
            child: SvgPicture.asset(
              "icons/s2wlogo.svg",
              color: Colors.white,
              fit: BoxFit.scaleDown
            ),
          ),
          DrawerListTile(
            title: "Data Projects",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<MainScreenViewModel>(context, listen: false)
                  .setScreen(Screen.data);
              },
          ),
          DrawerListTile(
            title: "Regex Projects",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Provider.of<MainScreenViewModel>(context, listen: false)
                  .setScreen(Screen.regex);
            },
          ),
          DrawerListTile(
            title: "Cleansing Process",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Provider.of<MainScreenViewModel>(context, listen: false)
                  .setScreen(Screen.cleanse);
            },
          ),
          // DrawerListTile(
          //   title: "Store",
          //   svgSrc: "assets/icons/menu_store.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Profile",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {
          //     Provider.of<MainScreenViewModel>(context, listen: false)
          //         .setScreen(Screen.settings);
          //   },
          // ),
        ],
      ),
    );
  }

}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
