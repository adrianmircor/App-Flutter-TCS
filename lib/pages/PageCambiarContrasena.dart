import 'package:detalle_pago_api/models/Usuario.dart';
import 'package:flutter/material.dart';

import "package:http/http.dart" as http; //peticiones http
import "dart:convert"; //Convertir los datos del backend a JSON y poder usarlo en la app

class CambiarContrasena extends StatefulWidget {
  CambiarContrasena({Key key}) : super(key: key);

  @override
  _CambiarContrasenaState createState() => _CambiarContrasenaState();
}

class _CambiarContrasenaState extends State<CambiarContrasena> {
  String _id = ""; //id es el dni del usuario
  String _correo = "";
  String _contrasena1 = "";
  String _contrasena2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cambiar Contraseña", style: TextStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 230.0),
        child: Container(
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
                height: 15,
              ),
              widgetContrasena1(),
              SizedBox(
                height: 15,
              ),
              widgetContrasena2(),
              SizedBox(
                height: 20,
              ),
              widgetBotonCambiar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetDni() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 265,
      child: TextField(
        keyboardType: TextInputType.number,
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

  Widget widgetBotonCambiar() {
    return Container(
      width: 265,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          apiCambiar();
        },
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color.fromRGBO(50, 132, 255, 1),
        child: Text(
          'Cambiar',
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

  void apiCambiar() async {
    if (_contrasena1 != _contrasena2) {
      print("Contraseñas distintas");
      return;
    }

    List usuarioData;
    http.Response response1 = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/alumnoprograma/buscard/$_id");
    debugPrint(response1.body);
    usuarioData = json.decode(response1.body);

    if (usuarioData.length != 0) {
      print("EXISTE EL ID => Existe el usuario");
      http.Response response2 = await http.get(
          "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/actualizar/$_id/$_correo/$_contrasena1");

      if (response2.statusCode == 200) {
        print("SE CAMBIÓ LA CONTRASEÑA a $_contrasena1");
      } else {
        print("EMAIL INCORRECTO");
      }
    } else {
      print("USUARIO INCORRECTO");
    }
  }

  Widget widgetContrasena1() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 265,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), //Borde de la caja
            ),
            prefixIcon: Icon(Icons.lock), //Icono al inicio de la caja
            hintText: "Nueva Contraseña", //Placeholder de una web
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(0)),
        onChanged: (valor) {
          setState(() {
            _contrasena1 = valor;
          });
        },
      ),
    );
  }

  Widget widgetContrasena2() {
    return Container(
      padding: EdgeInsets.all(0),
      width: 265,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), //Borde de la caja
            ),
            prefixIcon: Icon(Icons.lock), //Icono al inicio de la caja
            hintText: "Confirmar Contraseña", //Placeholder de una web
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(0)),
        onChanged: (valor) {
          setState(() {
            _contrasena2 = valor;
          });
        },
      ),
    );
  }
}
