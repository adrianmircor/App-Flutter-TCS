class Usuario {
  final String codAlumno;
  final String nomAlumno;
  final String dniM;

  Usuario({this.codAlumno, this.nomAlumno, this.dniM});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    //Como son PARAMETROS OPCIONALES, para ASIGNAR VALORES se usa :
    return new Usuario(
      codAlumno: json['codAlumno'],
      nomAlumno: json['nomAlumno'],
      dniM: json['dniM'],
    );
  }
}
