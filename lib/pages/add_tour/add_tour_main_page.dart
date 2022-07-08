import 'package:app_tours/pages/add_tour/MyTours.dart';
import 'package:app_tours/pages/add_tour/Profile.dart';
import 'package:app_tours/pages/add_tour/VirtualToursPage.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/widgets/app_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class AddTourMainPage extends StatefulWidget {
  const AddTourMainPage({Key? key}) : super(key: key);

  @override
  State<AddTourMainPage> createState() => _AddTourMainPageState();
}

class _AddTourMainPageState extends State<AddTourMainPage> {
  late List<Widget> pages;
  int indexSelected=1;
  @override
  void initState() {
    pages=[
      ToursPage(isEditor: false),
      VirtualTourPage(),
      ProfilePage(),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarSpace(context, false),
      body: pages[indexSelected],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColors.primaryColor,
        initialActiveIndex: 1,
        items: [
          TabItem(icon: Icons.apps, title: ''),
          TabItem(icon: Icons.add, title: ''),
          TabItem(icon: Icons.person, title: ''),
        ],
        onTap: (index){
          setState(() {
            indexSelected=index;
          });
        },
      ),
    );
  }
}
