/*
 *Falta formato del nombre del usuario 
 */

import 'package:detalle_pago_api/pages/PageDetallePago.dart';
import 'package:flutter/material.dart';

import 'package:detalle_pago_api/models/Usuario.dart';
import 'package:detalle_pago_api/models/ListaProgramas.dart';

import "package:http/http.dart" as http; //peticiones http
import "dart:convert"; //Convertir los datos del backend a JSON y poder usarlo en la app

class Programas extends StatefulWidget {
//Declara un campo que contenga la clase Usuario
  final Usuario user;

  Programas({Key key, @required this.user}) : super(key: key);

  @override
  _ProgramasState createState() => _ProgramasState(this.user);
}
/* ------------------------------------------------------------- */

class _ProgramasState extends State<Programas> {
  Usuario user;
  _ProgramasState(this.user);

  List listaProgramasData = new List();

  getProgramas() async {
    List programaData = new List();

    http.Response response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/alumnoprograma/buscard/${user.dniM}"); //"http://10.0.2.2:4000/api/users" para uso del emulador
    //debugPrint(response.body); // muestra por consola los datos de la api
    programaData = json.decode(response.body); //Pasa a Map
    //print("Recuperado de api-> $programaData");
    ProgramaList objetoListaProgramas = new ProgramaList.fromJson(programaData);

    setState(() {
      listaProgramasData = objetoListaProgramas.programaList;
    });
  }

  //Apenas se llama a esta clase, que se ejecute initState()
  @override
  void initState() {
    super.initState();
    getProgramas();
  }

  Widget cardDetallePrograma(List listaProgramasData, int i) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: <Widget>[
            rowNombrePrograma(listaProgramasData, i),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallePago(
              enviandoCodigoAlumno: listaProgramasData[i].codigoAlumno,
              enviandoNombrePrograma: listaProgramasData[i].nombre,
            ), 
            //Se le envia a la clase DetallePago el atributo enviandoCodigoAlumno
          ),
        );
      },
    );
  }

  Widget rowNombrePrograma(List listaProgramasData, int i) {
    return Row(
      children: <Widget>[
        Icon(Icons.card_travel),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            listaProgramasData[i].nombre,
            softWrap: true,
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, //Elimina la flecha 'Atrás'
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("MIS PROGRAMAS"), //cambiar a un solo CARD
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 40,
                          child: Text(
                            "${user.nomAlumno}",
                            style: TextStyle(fontSize: 10),
                            softWrap: true,
                          )
                      ),
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/rostro.jpg"),
                          radius: 23,
                        ),
                      )
                    ],
                  ),
                  //Text("${user.nomAlumno}"), ARREGLAR ESTO
                ],
              ),
            ],
          ),
        ),
        body: Container(
          //nombreDetallePago(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: listaProgramasData == null
                      ? 0
                      : listaProgramasData.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: cardDetallePrograma(listaProgramasData, i)
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
