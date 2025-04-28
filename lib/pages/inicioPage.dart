import 'package:flutter/material.dart';
import 'package:cde_amistad/entity/noticiaEntity.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> noticiasMock = [
      {
        "titulo": "¡Victoria épica!",
        "descripcion": "El CDE Amistad gana 3-2 en un partido inolvidable.",
        "contenido": "En un partido lleno de emoción, nuestro equipo logró una victoria histórica gracias al gol de último minuto...",
        "imagen": "https://picsum.photos/400/200"
      },
      {
        "titulo": "Nuevos entrenamientos",
        "descripcion": "Inscripciones abiertas para verano.",
        "contenido": "Desde el 1 de junio comenzamos la preparación para la próxima temporada. Inscríbete ya y forma parte de la familia CDE Amistad.",
        "imagen": "https://picsum.photos/400/200"
      },
      {
        "titulo": "Fiesta del Club",
        "descripcion": "No te pierdas nuestra gran fiesta familiar.",
        "contenido": "Este sábado a las 18:00h te esperamos en las instalaciones del club para disfrutar juntos de una jornada inolvidable.",
        "imagen": "https://picsum.photos/400/200"
      },
    ];

    final List<Map<String, String>> eventosMock = [
      {
        "titulo": "Partido vs Dragones",
        "fecha": "5 mayo, 18:00h",
        "lugar": "Estadio Principal",
      },
      {
        "titulo": "Fiesta del Club",
        "fecha": "10 mayo, 20:00h",
        "lugar": "Club Social",
      },
      {
        "titulo": "Entrenamiento Especial",
        "fecha": "12 mayo, 17:00h",
        "lugar": "Campo 2",
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Inicio',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido al CDE Amistad',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Últimas noticias:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  // Noticias
                  ...noticiasMock.map((noticia) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoticiaEntity(
                            titulo: noticia['titulo']!,
                            contenido: noticia['contenido']!,
                            imagen: noticia['imagen']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            noticia['imagen']!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          noticia['titulo']!,
                          style:
                          const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(noticia['descripcion']!),
                        trailing:
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  )),

                  const SizedBox(height: 30),

                  // Eventos Próximos
                  const Text(
                    'Eventos próximos:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventosMock.length,
                      itemBuilder: (context, index) {
                        final evento = eventosMock[index];
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.event,
                                  size: 30, color: Colors.green),
                              const SizedBox(height: 8),
                              Text(
                                evento['titulo']!,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                evento['fecha']!,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              Text(
                                evento['lugar']!,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
