import 'package:app_tours/initalConfigurations/TourAvaliable.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:app_tours/widgets/app_bar.dart';
import 'package:app_tours/widgets/itemCard.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class VirtualTourPage extends StatefulWidget {
  const VirtualTourPage({Key? key}) : super(key: key);

  @override
  State<VirtualTourPage> createState() => _VirtualTourPageState();
}

class _VirtualTourPageState extends State<VirtualTourPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: appBarSpace(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tour Virtual',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            gridTours()
          ],
        ),

      ),

    );
  }

  Widget gridTours() {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(20),
        children: List.generate(toursAvaliables.length, (index) {
          return Center(
            child: SelectCard(

              tourDisponibleApp: toursAvaliables.values.toList()[index],
              type_slug: toursAvaliables.keys.toList()[index],
            ),
          );
        }));
  }
}


class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.tourDisponibleApp,required this.type_slug})
      : super(key: key);
  final TourAvaliable tourDisponibleApp;
  final String type_slug;

  @override
  Widget build(BuildContext context) {

    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    const TextStyle textStyle = TextStyle(fontSize: 20);
    return itemCard(context, tourDisponibleApp, '/toursDisponibles/informationTour',type_slug);
  }
}
