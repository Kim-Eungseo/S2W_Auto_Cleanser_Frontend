import 'package:admin/viewmodels/menu_viewmodel.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/main_screen_viewmodel.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuProvider>().controlMenu,
          ),
        if (Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Auto-Cleansing Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),

        SizedBox(width: defaultPadding),
        Consumer<MainScreenViewModel>(
            builder: (context, mainScreen, child) {
              if (mainScreen.isLoading) {
                return Text("Loading...");
              } else {
                return SizedBox(width: 0, height: 0,);
              }
            }
        ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        SizedBox(width: defaultPadding),
        if (!Responsive.isMobile(context))
          Expanded(
          child: SearchField(),
          ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "This is 4 just ganzi",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text("미안"),
          ),
        ),
      ),
    );
  }
}
