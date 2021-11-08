
class Mensaje {
  final String texto;
  final DateTime fecha;

  Mensaje(this.texto,this.fecha);

  Mensaje.fromJson(Map<dynamic, dynamic> json)
    : fecha = DateTime.parse(json['fecha'] as String),
      texto = json['texto'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'fecha': fecha.toString(),
    'texto': texto,
  };
}