import 'package:app_tours/models/Tour.dart';
import 'package:app_tours/pages/visualizer_page.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTourDelegate extends SearchDelegate<List<dynamic>>{
  List<dynamic> tours;
  List<dynamic> _filter=[];

  SearchTourDelegate(this.tours);
  SharedPref sharedPref = SharedPref();


  @override
  Widget buildSuggestions(BuildContext context) {

    _filter = tours.where((element){
      return element['title'].toString().toLowerCase().contains(query.trim().toLowerCase());
    }).toList();

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return       ListView.builder(
              itemCount: _filter.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                      onTap: () async {
                        Tour tourSaved = await context.read<TourProvider>().mapToTour(
                            tourSaved: _filter[index]);
                        context.read<TourProvider>().newTour =
                            tourSaved;
                        print(tourSaved.type);
                        Navigator.pushNamed(context,
                            '/toursDisponibles/${tourSaved.type}',
                            arguments: {
                              'formData': tourSaved.infoTour,
                              'case': true,
                              'index': index
                            });

                        //print(snapshot.data![index]);
                      },
                      leading: const Icon(Icons.threesixty),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         /* MaterialButton(
                            onPressed: () async {
                  Tour tourSaved = await context.read<TourProvider>().mapToTour(
                  tourSaved: _filter[index]);
                  setState(() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VisualizerPage(tourSaved: tourSaved)));

                  });

                  //setState(() {});
                  },
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            child: const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                            ),
                            padding: const EdgeInsets.all(1),
                            shape: const CircleBorder(),
                          ),*/
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                sharedPref.remove(
                                    'nuevo_tour', index);
                                _filter.removeAt(index);
                              });


                            },
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                            ),
                            padding: const EdgeInsets.all(1),
                            shape: const CircleBorder(),
                          ),
                        ],
                      ),
                      subtitle: (_filter[index]['type'] != "otro")
                          ? Text(
                        _filter[index]['type'],
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 15),
                      )
                          : Text(
                        _filter[index]['infoTour']['tipo_aux'],
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 15),
                      ),
                      title: Text(_filter[index]['title'])),
                );
              });
        });



  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return  IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return       ListView.builder(
              itemCount: _filter.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                      onTap: () async {
                        Tour tourSaved = await context.read<TourProvider>().mapToTour(
                            tourSaved: _filter[index]);
                        context.read<TourProvider>().newTour =
                            tourSaved;
                        print(tourSaved.type);
                        Navigator.pushNamed(context,
                            '/toursDisponibles/${tourSaved.type}',
                            arguments: {
                              'formData': tourSaved.infoTour,
                              'case': true,
                              'index': index
                            });

                        //print(snapshot.data![index]);
                      },
                      leading: const Icon(Icons.threesixty),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              Tour tourSaved = await context.read<TourProvider>().mapToTour(
                                  tourSaved: _filter[index]);
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VisualizerPage(tourSaved: tourSaved)));

                              });

                              //setState(() {});
                            },
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            child: const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                            ),
                            padding: const EdgeInsets.all(1),
                            shape: const CircleBorder(),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                sharedPref.remove(
                                    'nuevo_tour', index);
                                _filter.removeAt(index);
                              });


                            },
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                            ),
                            padding: const EdgeInsets.all(1),
                            shape: const CircleBorder(),
                          ),
                        ],
                      ),
                      subtitle: (_filter[index]['type'] != "otro")
                          ? Text(
                        _filter[index]['type'],
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 15),
                      )
                          : Text(
                        _filter[index]['infoTour']['tipo_aux'],
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 15),
                      ),
                      title: Text(_filter[index]['title'])),
                );
              });
        });
  }
}