import 'package:app_tours/initalConfigurations/InputsTour.dart';
import 'package:app_tours/initalConfigurations/TourAvaliable.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle textStyle = TextStyle();
final _formKey = GlobalKey<FormState>();
Map<String, String> formData = {};
TextEditingController otherTypeInputController = TextEditingController();

Widget makeInput({required InputsTour inputTour}) {
  return (inputTour.slug == 'tipo_aux')
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
              child: Text('De que será el tour', style: TextStyle(fontSize: 16),),
            ),
            TextFormField(
              onSaved: (value) {
                formData[inputTour.slug] = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Informacion requerida";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Ex. Universidad',
                prefixIcon: Icon(inputTour.icon),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: const OutlineInputBorder(),
              ),
            ),
            const Divider(),
          ],
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onSaved: (value) {
                formData[inputTour.slug] = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Informacion requerida";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: inputTour.label,
                prefixIcon: Icon(inputTour.icon),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        );
}

Widget itemCard(
    BuildContext context, TourAvaliable tour, String route, String typeSlug) {
  //formData={};
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: colorsApp['primaryColor'],
      child: InkWell(
        onTap: () {
          //print('tap');
          //Navigator.of(context).pushNamed(route);
          formData = {};

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      //overflow: Overflow.visible,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          //height: 200,
                          child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Informacion del tour',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 10),
                                      for (int i = 0;
                                          i < tour.inputs.length;
                                          i++)
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              makeInput(
                                                  inputTour: tour.inputs.values
                                                      .toList()[i]),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                primary: Colors.transparent,
                                                shadowColor: Colors.transparent
                                                    .withOpacity(0.1),
                                                side: const BorderSide(
                                                  width: 2,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                context
                                                    .read<TourProvider>()
                                                    .cancelTour();
                                              },
                                              child: const Text("Cerrar")),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState?.save();

                                                  print('slug:' + typeSlug);
                                                  context
                                                      .read<TourProvider>()
                                                      .cancelTour();
                                                  Navigator.pushNamed(context,
                                                      '/toursDisponibles/$typeSlug',
                                                      arguments: {
                                                        'formData': formData,
                                                        'case': false,
                                                        'index': 999
                                                      });
                                                }
                                              },
                                              child: const Text("Continuar"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Expanded(*/
                Icon(tour.icon, size: 45, color: colorsApp['iconColor']),
                /*),*/
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text(tour.title, style: const TextStyle(fontSize: 16))),
              ]),
        ),
      ));
}
