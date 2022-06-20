import 'package:app_tours/pages/Profile.dart';
import 'package:app_tours/pages/MyTours.dart';
import 'package:app_tours/pages/VirtualToursPage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  int index;
  Home({Key? key,required this.index}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedpage = 0;

  @override
  void initState(){
    super.initState();
    selectedpage=widget.index;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      homeWidget(),
      ToursPage(),
      VirtualTourPage(),
      ProfilePage()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarSpace(),
      body: _pages[selectedpage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color.fromARGB(255, 66, 66, 66),
        items: [
          TabItem(icon: Icons.home, title: ''),
          TabItem(icon: Icons.apps, title: ''),
          TabItem(icon: Icons.add, title: ''),
          TabItem(icon: Icons.person, title: ''),
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
    );
  }

  Widget bottomBar(int selectedpage) {
    return ConvexAppBar(
      backgroundColor: Color.fromARGB(255, 66, 66, 66),
      items: [
        TabItem(icon: Icons.apps, title: ''),
        TabItem(icon: Icons.add, title: ''),
        TabItem(icon: Icons.person, title: ''),
      ],
      initialActiveIndex: selectedpage,
      onTap: (int index) {
        setState(() {
          selectedpage = index;
        });
      },
    );
  }

  Widget homeWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: new Image.asset(
                    'assets/images/home.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  elevatedButtonHome(100.0, 150.0, 'Ejemplo tours virtuales'),
                  elevatedButtonHome(100.0, 150.0, 'Tutoriales'),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget elevatedButtonHome(double alto, double ancho, String texto) {
    return SizedBox(
      height: alto, //height of button
      width: ancho, //width of button
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary:
                Color.fromARGB(255, 66, 66, 66), //background color of button
            //side: BorderSide(  width: 3, color: Colors.brown), //border width and color
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(20) //content padding inside button
            ),
        onPressed: () {},
        child: Text(
          texto,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  AppBar appBarSpace() {
    return AppBar(
      title: Text('Virtual Space '),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home_outlined),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }
}
