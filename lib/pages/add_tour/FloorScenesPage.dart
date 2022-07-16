import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/ReelImage.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/widgets/itemCardScene.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FloorScenesPage extends StatefulWidget {
  Floor floor;
  List<ScenesInTourModel> scenes;
  FloorScenesPage({Key? key, required this.floor, required this.scenes})
      : super(key: key);

  @override
  State<FloorScenesPage> createState() => _FloorScenesPageState();
}

class _FloorScenesPageState extends State<FloorScenesPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: const EdgeInsets.all(10),
        children: List.generate(widget.scenes.length, (index) {

          return Center(
              child: DragTarget(
            onWillAccept: (data) {
              if(widget.scenes[index].slug=='otros'){
                Fluttertoast.showToast(msg: 'Ingrese a esta seccion para añadir escenas');
                return false;
              }
              return true;
            },
            onAccept: (dynamic data) {

              if(data.runtimeType == List<ReelImage>){
                data.map((e) =>
                    context.read<TourProvider>().newTour.floors![widget.floor.slug]!.scenes![widget.scenes[index].slug]!.imageList.add(e.image)
                ).toList();
              }else{
                context.read<TourProvider>().newTour.floors![widget.floor.slug]!.scenes![widget.scenes[index].slug]!.imageList.add(data.image);
              }

            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return ItemCardScene(
                  sceneInTour: widget.scenes[index], floor: widget.floor);
            },
          ));
        }));
  }
}
