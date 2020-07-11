
import 'package:detalle_pago_api/models/Programa.dart';

class ProgramaList{

  final List<Programa> programaList;


  ProgramaList({this.programaList});

  factory ProgramaList.fromJson(List<dynamic> parsedJson){

    List<Programa> programaList = new List<Programa>();
    programaList = parsedJson.map((i) => Programa.fromJson(i)).toList();

    //Como son PARAMETROS OPCIONALES, para ASIGNAR VALORES se usa :
    return new ProgramaList(
      programaList: programaList,
    );

  }


}