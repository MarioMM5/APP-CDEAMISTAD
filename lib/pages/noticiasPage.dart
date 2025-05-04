import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/widget/noticia_card.dart';
import 'package:cde_amistad/widget/noticias_detail.dart';

class NoticiasPage extends StatelessWidget {
  const NoticiasPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchNoticias() async {
    final response = await Supabase.instance.client
        .from('noticias')
        .select()
        .order('fecha', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Noticias del Club")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNoticias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error al cargar noticias"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay noticias disponibles"));
          }

          final noticias = snapshot.data!;

          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              final fecha = DateTime.parse(noticia['fecha']);

              return NoticiaCard(
                titulo: noticia['titulo'],
                descripcion: noticia['descripcion'],
                imagenUrl: noticia['imagen'],
                fecha: fecha,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticiaDetail(
                        titulo: noticia['titulo'],
                        contenido: noticia['contenido'],
                        imagen: noticia['imagen'],
                        fecha: fecha,
                      ),
                    ),
                  );
                },

              );


            },
          );
        },
      ),
    );
  }
}
