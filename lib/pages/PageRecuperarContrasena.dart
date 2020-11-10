import 'package:flutter/material.dart';

import "package:http/http.dart" as http; //peticiones http
import "dart:convert"; //Convertir los datos del backend a JSON y poder usarlo en la app.

class RecuperarContrasena extends StatefulWidget {
  RecuperarContrasena({Key key}) : super(key: key);

  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  String _id = ""; //id es el dni del usuario
  String _correo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Recuperar Contraseña", style: TextStyle(fontSize: 20)),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
            widgetDni(),
            SizedBox(
              height: 15,
            ),
            widgetCorreo(),
            SizedBox(
              height: 20,
            ),
            widgetBotonRecuperar(),
          ],
        ),
      ),
    );
  }

  Widget widgetDni() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 265,
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), //Borde de la caja
            ),
            prefixIcon: Icon(Icons.perm_identity), //Icono al inicio de la caja
            hintText: "Ingrese su Dni", //Placeholder de una web
            isDense: true, // Added this
            contentPadding: EdgeInsets.symmetric(vertical: 0)),
        onChanged: (valor) {
          setState(() {
            _id = valor;
          });
        },
      ),
    );
  }

  Widget widgetCorreo() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 265,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), //Borde de la caja
            ),
            prefixIcon:
                Icon(Icons.alternate_email), //Icono al inicio de la caja
            hintText: "Ingrese su correo", //Placeholder de una web
            isDense: true, // Added this
            contentPadding: EdgeInsets.symmetric(vertical: 0)),
        onChanged: (valor) {
          setState(() {
            _correo = valor;
          });
        },
      ),
    );
  }

  Widget widgetBotonRecuperar() {
    return Container(
      width: 265,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          apiRecuperar();
        },
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color.fromRGBO(50, 132, 255, 1),
        child: Text(
          'Recuperar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void apiRecuperar() async {

    List usuarioData;
    http.Response response1 = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/alumnoprograma/buscard/$_id");
    debugPrint(response1.body);
    usuarioData = json.decode(response1.body); //puede retornar [] en caso no encuentre el id

    if (usuarioData.length != 0) {
      print("EXISTE EL ID => Existe el usuario");
      http.Response response2 = await http.get(
          "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/cambiar/$_correo/$_id");

      if (response2.statusCode == 200) {
        print("SE CAMBIÓ LA CONTRASEÑA ");
      } else {
        print("EMAIL INCORRECTO");
      }
    } else {
      print("USUARIO INCORRECTO");
    }
  }
}
