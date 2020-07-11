import 'package:detalle_pago_api/models/Pago.dart';

class PagoList {
  final List<Pago> pagoList;

  //PagoList({ otorgar VALORES a los parametros EN CUALQUIER ORDEN y son OPCIONALES })
  PagoList({ this.pagoList }); 

  //metodo FACTORY hace que un CONSTRUCTOR PUEDA RETORNAR algo
  factory PagoList.fromJson(List<dynamic> parsedJson) {
    
    List<Pago> pagoList = new List<Pago>();
    pagoList = parsedJson.map((i) => Pago.fromJson(i)).toList();

    //Como son PARAMETROS OPCIONALES, para ASIGNAR VALORES se usa :
    return new PagoList(
      pagoList: pagoList,
    );
  }
  
}
