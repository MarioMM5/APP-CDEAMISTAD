import 'package:flutter/material.dart';

class Noticia {
  final String titulo;
  final String descripcion;
  final String imagenUrl;
  final DateTime fecha;

  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.imagenUrl,
    required this.fecha,
  });
}

final List<Noticia> noticias = [
  Noticia(
    titulo: "Golazo en el último minuto",
    descripcion: "El delantero marcó un gol increíble al final del partido.",
    imagenUrl: "https://picsum.photos/400/200",
    fecha: DateTime.now(),
  ),
  Noticia(
    titulo: "Entrenamiento abierto",
    descripcion: "El club invita a los hinchas al entrenamiento del sábado.",
    imagenUrl: "https://picsum.photos/400/200",
    fecha: DateTime.now().subtract(Duration(days: 1)),
  ),
  Noticia(
    titulo: "Diego gay",
    descripcion: "Mazo gay.",
    imagenUrl: "https://picsum.photos/400/200",
    fecha: DateTime.now().subtract(Duration(days: 1)),
  ),
];

class NoticiasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Noticias del Club")),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          final noticia = noticias[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(noticia.imagenUrl),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(noticia.titulo, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(noticia.descripcion),
                      SizedBox(height: 5),
                      Text(
                        "${noticia.fecha.day}/${noticia.fecha.month}/${noticia.fecha.year}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
