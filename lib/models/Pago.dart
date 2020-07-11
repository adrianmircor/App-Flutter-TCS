class Pago {

  final String concepto;
  final String idRec;
  final String fecha;
  final String moneda2;
  final String importe;

  //Pago({ otorgar VALORES a los parametros EN CUALQUIER ORDEN y son OPCIONALES })
  Pago({this.concepto, this.idRec, this.fecha, this.moneda2, this.importe});

  //metodo FACTORY hace que un CONSTRUCTOR PUEDA RETORNAR algo
  factory Pago.fromJson(Map<String, dynamic> json) {
    //Como son PARAMETROS OPCIONALES, para ASIGNAR VALORES se usa :
    return new Pago(
      concepto: json['concepto'],
      idRec: json['idRec'].toString(),
      fecha: json['fecha'],
      moneda2: json['moneda2'],
      importe: json['importe'].toString(),
    );
  }

}
