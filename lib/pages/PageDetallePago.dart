import 'package:flutter/material.dart';

import "package:http/http.dart" as http; //peticiones http
import "dart:convert"; //Convertir los datos del backend a JSON y poder usarlo en la app

import 'package:detalle_pago_api/models/ListaPagos.dart';

class DetallePago extends StatefulWidget {

  //Recibe el atributo 'enviandoCodigoAlumno' de PageProgramas.dart
  final String enviandoCodigoAlumno ;
  final String enviandoNombrePrograma ;

  DetallePago({Key key, @required this.enviandoCodigoAlumno, @required this.enviandoNombrePrograma}) : super(key: key);

  @override
  _DetallePagoState createState() => _DetallePagoState(this.enviandoCodigoAlumno, this.enviandoNombrePrograma);
}

/* ------------------------------------------------------------- */

class _DetallePagoState extends State<DetallePago> {
  
  String codigoAlumno;
  String nombrePrograma;
  List listaPagosData = new List();

  _DetallePagoState(this.codigoAlumno, this.nombrePrograma);

  getPagos() async {
    List pagosData = new List();

    http.Response response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/recaudaciones/alumno/concepto/listar_cod/$codigoAlumno"); //"http://10.0.2.2:4000/api/users" para uso del emulador
    print("Imprimir");
    debugPrint(response.body);// muestra por consola los datos de la api
    pagosData = json.decode(response.body); //Pasa a Map
    //print("Recuperado de api-> $pagosData");
    PagoList objetoListaPagos = new PagoList.fromJson(pagosData);
    /* pagosData = objetoListaPagos.pagoList;
    print("LISTA RECUPERADA EN main.dart ->> ${objetoListaPagos.pagoList}");
    print("Accediento al primer objeto DATA->> ${objetoListaPagos.pagoList[0].concepto}"); */

    //print("Usando lo recuperado de api-> ${pagosData[0].idRec} ${pagosData[0].idAlum}");

    setState(() {
      listaPagosData = objetoListaPagos.pagoList;
      //print("Parseado a Lista, ya puede ser usado en widget-> $listaPagosData");
    });
  }

  //Apenas se llama a la clase HomePage, que se ejecute initState()
  @override
  void initState() {
    super.initState();
    getPagos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("DETALLE DE PAGOS"),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/rostro.jpg"),
                    radius: 23,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        //nombreDetallePago(),
        child: Column(
          children: <Widget>[
            nombreDetallePago(),
            Expanded(
              child: ListView.builder(
                itemCount: listaPagosData == null ? 0 : listaPagosData.length,
                itemBuilder: (BuildContext context, int i) {
                  return cardDetallePago(listaPagosData, i);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nombreDetallePago() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
            left: 15, top: 0, right: 15, bottom: 12), //De la caja
        child: Card(
            elevation: 10,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              //Propio del Texto
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$nombrePrograma",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            )),
      ),
    );
  }

  Widget rowConcepto(List pagosData, int i) {
    return Row(
      children: <Widget>[
        Icon(Icons.credit_card, color: Colors.blue),
        SizedBox(width: 10),
        Text("Concepto: ", style: TextStyle(fontWeight: FontWeight.w800)),
        Text(pagosData[i].concepto),
      ],
    );
  }

  Widget rowRecibo(List pagosData, int i) {
    return Row(
      children: <Widget>[
        Icon(Icons.code, color: Colors.blue),
        SizedBox(width: 10),
        Text("N° Recibo: ", style: TextStyle(fontWeight: FontWeight.w700)),
        Text(pagosData[i].idRec),
      ],
    );
  }

  Widget rowFecha(List pagosData, int i) {
    return Row(
      children: <Widget>[
        Icon(Icons.event_available, color: Colors.blue),
        SizedBox(width: 10),
        Text("Fecha: ", style: TextStyle(fontWeight: FontWeight.w700)),
        Text(pagosData[i].fecha)
      ],
    );
  }

  Widget rowMoneda(List pagosData, int i) {
    return Row(
      children: <Widget>[
        Icon(Icons.stars, color: Colors.blue),
        SizedBox(width: 10),
        Text("Moneda: ", style: TextStyle(fontWeight: FontWeight.w700)),
        Text(pagosData[i].moneda2),
      ],
    );
  }

  Widget rowImporte(List pagosData, int i) {
    return Row(
      children: <Widget>[
        Icon(Icons.attach_money, color: Colors.blue),
        SizedBox(width: 10),
        Text("Importe: ", style: TextStyle(fontWeight: FontWeight.w700)),
        Text("S/ ${pagosData[i].importe}"),
      ],
    );
  }

  Widget cardDetallePago(List pagosData, int i) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: <Widget>[
              rowConcepto(pagosData, i),
              SizedBox(height: 6),
              rowRecibo(pagosData, i),
              SizedBox(height: 6),
              rowFecha(pagosData, i),
              SizedBox(height: 6),
              rowMoneda(pagosData, i),
              SizedBox(height: 6),
              rowImporte(pagosData, i),
              SizedBox(height: 6),
            ],
          ),
        )
    );
  }

}