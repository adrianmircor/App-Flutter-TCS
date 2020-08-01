import 'package:detalle_pago_api/models/Usuario.dart';
import 'package:detalle_pago_api/pages/PageCambiarContrasena.dart';
import 'package:detalle_pago_api/pages/PageProgramas.dart';
import 'package:detalle_pago_api/pages/PageRecuperarContrasena.dart';
import 'package:flutter/material.dart';

import "package:http/http.dart" as http; //peticiones http
import "dart:convert"; //Convertir los datos del backend a JSON y poder usarlo en la app

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _id = "";
  String _contrasena = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 250.0),
        child: Container(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Consulta de Pagos", style: TextStyle(fontSize: 20)),
                  Text("POSGRADO", style: TextStyle(fontSize: 20)),
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.asset("assets/Logo-UNMSM.png", width: 180)),
                  SizedBox(
                    height: 20,
                  ),
                  widgetDni(),
                  SizedBox(
                    height: 15,
                  ),
                  widgetContrasena(),
                  widgetOlvideContrasena(),
                  SizedBox(
                    height: 10,
                  ),
                  widgetBotonIniciarSesion(),
                  widgetCambiarContrasena(),
                ],
              )
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
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), //Borde de la caja
            ),
            prefixIcon: Icon(Icons.perm_identity), //Icono al inicio de la caja
            hintText: "Dni", //Placeholder de una web
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

  Widget widgetContrasena() {
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
            hintText: "Contraseña", //Placeholder de una web
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(0)),
        onChanged: (valor) {
          setState(() {
            _contrasena = valor;
          });
        },
      ),
    );
  }

  Widget widgetBotonIniciarSesion() {
    return Container(
      width: 265,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          print("Datos ingresados: ");
          print("Id: $_id / Contraseña: $_contrasena");
          verificarLogin();
        },
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color.fromRGBO(50, 132, 255, 1),
        child: Text(
          'Iniciar Sesión',
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

  void verificarLogin() async {
    Map usuarioData;

    print("Aqui va la consulta a la API");
    http.Response response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/buscar/$_contrasena/$_id"); //"http://10.0.2.2:4000/api/users" para uso del emulador
    //print("trayendo datos");
    if (response.statusCode != 200) {
      print("No existe el usuario");
    } else {
      print("Existe el usuario");
      //debugPrint(response.body); // muestra por consola los datos de la api
      usuarioData = json.decode(response.body); //Pasa a Map
      Usuario user = new Usuario.fromJson(usuarioData);
      //Envia el codigo del alumno a la otra ventana
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Programas(user: user),
        ),
      );
    }
  }

  Widget widgetOlvideContrasena() {
    return Container(
      padding: EdgeInsets.only(right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Text("Olvidé mi contraseña",
                style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecuperarContrasena(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget widgetCambiarContrasena() {
    return Container(
        padding: EdgeInsets.only(top: 5),
        child: GestureDetector(
          child: Text("Quiero cambiar mi contraseña",
              style: TextStyle(fontSize: 13)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CambiarContrasena(),
              ),
            );
          },
        ));
  }
}
