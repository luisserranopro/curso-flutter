import 'package:flutter/material.dart';

void main() => runApp(MiApp());

class ArgumentosRuta {
  final String titulo;
  final String mensaje;

  ArgumentosRuta(this.titulo, this.mensaje);
}


class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == RutaPasarArgumentos.nombreRuta) {
          final ArgumentosRuta args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return RutaPasarArgumentos(
                titulo: args.titulo,
                mensaje: args.mensaje,
              );
            },
          );
        }
      },
      title: 'Navegación con argumentos',
      home: RutaInicio(),
    );
  }
}

class RutaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Navegar a la ruta que extrae los argumentos"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RutaExtraerArgumentos(),
                    settings: RouteSettings(
                      arguments: ArgumentosRuta(
                        'Extraer Ruta de Argumentos',
                        'Este mensaje es extraido en el método build.',
                      ),
                    ),
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text("Navegar a una ruta con nombre que acepta argumentos"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RutaPasarArgumentos.nombreRuta,
                  arguments: ArgumentosRuta(
                    'Ruta que acepta argumentos',
                    'Este mensaje es extraído en el método onGenerateRoute.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RutaExtraerArgumentos extends StatelessWidget {
  static const nombreRuta = '/extraerArgumentos';

  @override
  Widget build(BuildContext context) {
    final ArgumentosRuta args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.titulo),
      ),
      body: Center(
        child: Text(args.mensaje),
      ),
    );
  }
}


class RutaPasarArgumentos extends StatelessWidget {
  static const nombreRuta = '/pasarArgumentos';

  final String titulo;
  final String mensaje;

  const RutaPasarArgumentos({
    Key key,
    @required this.titulo,
    @required this.mensaje,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Center(
        child: Text(mensaje),
      ),
    );
  }
}

