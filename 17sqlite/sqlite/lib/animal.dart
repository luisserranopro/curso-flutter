
class Animal {

  int id;
  String nombre;
  String especie;

  Animal({this.id, this.nombre, this.especie});

  Map<String, dynamic> toMap() {
    return { 'id': id, 'nombre': nombre, 'especie': especie};
  }
}