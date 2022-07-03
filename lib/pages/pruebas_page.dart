import 'package:app_tours/providers/auxProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PruebasPage extends StatefulWidget {
  const PruebasPage({Key? key}) : super(key: key);

  @override
  State<PruebasPage> createState() => _PruebasPageState();
}

class _PruebasPageState extends State<PruebasPage> {
  TextEditingController floorNameController = TextEditingController();
  String defaultValue = 'default';
  List<String> pisos=[];
  @override
  Widget build(BuildContext context) {
     pisos = context.read<PisosProviders>().pisos;
    print(pisos);
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          value: defaultValue,
          items: pisos.map((String e) {
            if(e=='agregar'){
              return DropdownMenuItem<String>(value: e,
                  child: MaterialButton(
                    onPressed: (){
                      context.read<PisosProviders>().addPiso('hola');
                      setState(() {
                        Navigator.pop(context);
                        defaultValue='hola';
                      });
                    },
                    child: Text('touchme'),

                  ),
              );

            }else{
              return DropdownMenuItem<String>(value: e, child: Text(e));

            }


          }).toList()

          ,
          onChanged: (value) {
            if(value!='agregar'){
              setState(() {

              });
            }else{

            }
            setState(() {
              this.pisos = context.read<PisosProviders>().pisos;
            });
            defaultValue = value!;
          },
        ),
      ),
    );
  }
}
