import 'package:app_tours/pages/add_tour/MyTours.dart';
import 'package:app_tours/pages/add_tour/add_tour_main_page.dart';
import 'package:app_tours/pages/on_work.dart';
import 'package:app_tours/widgets/app_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedpage = 0;
  bool homeSelected=true;
  late bool isEditor;

  @override
  void initState(){
    super.initState();
    selectedpage=0;
    isEditor= false;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      homeWidget(),
      ToursPage(isEditor: true),
      const OnWork(),

      //const ProfilePage(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarSpace(context, isEditor),
      body:(homeSelected)
        ?homeWidget()
      :_pages[selectedpage],
      /*_pages[selectedpage],*/
      bottomNavigationBar: ConvexAppBar(
        curveSize: 0,
        style: TabStyle.react,
        activeColor: Colors.grey,
        color: Colors.grey,
        top: 0,
        backgroundColor: const Color.fromARGB(255, 66, 66, 66),
        items: const [
          TabItem(icon: Icons.add, title: ''),
          TabItem(icon: Icons.edit, title: ''),
          TabItem(icon: FontAwesome5.eye, title: ''),
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            //homeSelected=true;
            //selectedpage = index;
            if(index==0){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const AddTourMainPage()));
              homeSelected=true;
              isEditor=false;
            }
            else if(index == 1){
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ToursPage()));
              homeSelected=false;
              selectedpage=index;
              isEditor=true;

            }
            else if(index == 2){
              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VisualizerPage()));
              homeSelected=false;
              selectedpage=index;
              isEditor=false;
            }

          });
        },
      ),
    );
  }

  Widget homeWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/home.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                const Color.fromARGB(255, 66, 66, 66), //background color of button
            //side: BorderSide(  width: 3, color: Colors.brown), //border width and color
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(20) //content padding inside button
            ),
        onPressed: () {},
        child: Text(
          texto,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
