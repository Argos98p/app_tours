import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/models/Scene.dart';
import 'package:app_tours/pages/ScenesInOthers.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemCardScene extends StatefulWidget {
  ScenesInTourModel sceneInTour;
  Floor floor;

  ItemCardScene({Key? key, required this.sceneInTour, required this.floor})
      : super(key: key);

  @override
  State<ItemCardScene> createState() => _ItemCardScenesState();
}

class _ItemCardScenesState extends State<ItemCardScene> {
  @override
  void initState() {
    //print(scene.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Scene scene = Scene(
        imageList: [],
        name: widget.sceneInTour.title,
        slug: widget.sceneInTour.slug);

    if (context
            .read<TourProvider>()
            .newTour
            .floors![widget.floor.slug]!
            .scenes![widget.sceneInTour.slug] ==
        null) {
      //print('Las esceneas todavia no estan creadas');
      context
          .read<TourProvider>()
          .newTour
          .floors![widget.floor.slug]!
          .scenes![widget.sceneInTour.slug] = scene;
    } else {
      scene = context
          .read<TourProvider>()
          .newTour
          .floors![widget.floor.slug]!
          .scenes![widget.sceneInTour.slug]!;
      //print('las escenas estan creadas');
    }

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorsApp['primaryColor'],
        child: InkWell(
          onTap: () {
            if (widget.sceneInTour.slug == 'otros') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      OthersScenes(floorSlug: widget.floor.slug!),
                ),
              );
            } else {
              _navigateAddImageAndReturn(
                  context, widget.sceneInTour, scene, widget.floor);
              setState(() {});
            }
          },
          child: Stack(children: [
            Positioned(
              right: 0,
              top: 0,
              child: widget.sceneInTour.slug == 'otros'
                  ? numScenesButton(widget.floor.others!.length)
                  : numScenesButton(scene.imageList.length),
            ),
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*Expanded(*/

                    Icon(widget.sceneInTour.icon,
                        size: 38, color: colorsApp['iconColor']),
                    /*),*/
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(widget.sceneInTour.title,
                            style: TextStyle(fontSize: 16))),
                  ]),
            ),
          ]),
        ));
  }

  Widget numScenesButton(int n) {
    //print('numero de escenas en '+widget.floor.slug! +'en la escena '+widget.sceneInTour.slug+' es :'+n.toString());
    if (n > 0) {
      setState(() {});
      return Container(
          width: 20,
          height: 20,
          decoration: new BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(n.toString())));
    } else {
      setState(() {});
      return Container(
          width: 20,
          height: 20,
          decoration: new BoxDecoration(
            color: colorsApp['secondaryColor'],
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(n.toString())));
    }
  }

  Future _navigateAddImageAndReturn(BuildContext context,
      ScenesInTourModel sceneInTour, Scene scene, Floor floor) async {
    //TourProvider watch = context.watch<TourProvider>();
    var imageFileList = await Navigator.pushNamed(
        context, '/toursDisponibles/agregarEscena', arguments: {
      "sceneName": widget.sceneInTour.title,
      'imageList': scene.imageList
    });
    if (imageFileList != null) {
      imageFileList as List<XFile>;
      //numScenes=imageFileList.length;
      scene.imageList = imageFileList;
      context
          .read<TourProvider>()
          .newTour
          .floors![floor.slug]!
          .scenes![sceneInTour.slug] = scene;
      setState(() {
        print(imageFileList.length.toString());
      });
      //print(numScenes);
    }
  }
}
