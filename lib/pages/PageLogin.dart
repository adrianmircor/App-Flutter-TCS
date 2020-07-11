import 'package:detalle_pago_api/models/Usuario.dart';
import 'package:detalle_pago_api/pages/PageProgramas.dart';
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
        padding: EdgeInsets.all(15.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 250.0),
        child: Container(
          padding: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Consulta de Pagos", style: TextStyle(fontSize: 20)),
                  Text("POSGRADO", style: TextStyle(fontSize: 20)),
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.asset("assets/Logo-UNMSM.png", width: 180)),
                  SizedBox(
                    height: 25,
                  ),
                  widgetDni(),
                  SizedBox(
                    height: 15,
                  ),
                  widgetContrasena(),
                  SizedBox(
                    height: 20,
                  ),
                  widgetBotonIniciarSesion(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void verificarLogin() async {
    Map usuarioData;

    print("Aqui va la consulta a la API");
    http.Response response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/buscar/$_id/$_contrasena"); //"http://10.0.2.2:4000/api/users" para uso del emulador
    print("trayendo datos");
    if (response.body == "") {
      print("No existe el usuario");
    } else {
      print("Existe el usuario");
      debugPrint(response.body); // muestra por consola los datos de la api
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
}
