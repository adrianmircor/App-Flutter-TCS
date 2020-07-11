class Programa{

  final String nombre;
  final String codigoAlumno;
  final String idPrograma;

  Programa({this.nombre, this.codigoAlumno, this.idPrograma});

  factory Programa.fromJson(Map<String,dynamic> json){

    return new Programa(
      nombre: json["nom_programa"],
      codigoAlumno: json["codAlumno"],
      idPrograma: json["idPrograma"].toString()
    );
  }


}