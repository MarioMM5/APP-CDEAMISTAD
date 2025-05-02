import 'package:flutter/material.dart';
import 'package:cde_amistad/entity/noticiaEntity.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart'; // Para parsear la fecha

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  Event buildEvent(String titulo, String lugar, DateTime fecha) {
    // Ajustamos el final del evento para asegurarnos de que haya una duración.
    return Event(
      title: titulo,
      description: 'Evento de CDE Amistad',
      location: lugar,
      startDate: fecha,
      endDate: fecha.add(const Duration(hours: 1)), // Se asigna una duración de 1 hora
      iosParams: IOSParams(reminder: Duration(minutes: 15)), // Opcional, para notificación en iOS
      androidParams: AndroidParams(
        emailInvites: ['correo@ejemplo.com'], // Puedes agregar correos si lo deseas
      ),
    );
  }


  DateTime parseFecha(String fechaTexto) {
    // Convierte "5 mayo, 18:00h" en DateTime
    final meses = {
      'enero': 1,
      'febrero': 2,
      'marzo': 3,
      'abril': 4,
      'mayo': 5,
      'junio': 6,
      'julio': 7,
      'agosto': 8,
      'septiembre': 9,
      'octubre': 10,
      'noviembre': 11,
      'diciembre': 12,
    };

    final partes = fechaTexto.split(',');
    final fechaPartes = partes[0].trim().split(' ');
    final horaPartes = partes[1].trim().replaceAll('h', '').split(':');

    final dia = int.parse(fechaPartes[0]);
    final mes = meses[fechaPartes[1].toLowerCase()]!;
    final hora = int.parse(horaPartes[0]);
    final minutos = int.parse(horaPartes[1]);

    final ahora = DateTime.now();
    return DateTime(ahora.year, mes, dia, hora, minutos);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> noticiasMock = [
      {
        "titulo": "¡Victoria épica!",
        "descripcion": "El CDE Amistad gana 3-2 en un partido inolvidable.",
        "contenido":
        "En un partido lleno de emoción, nuestro equipo logró una victoria histórica gracias al gol de último minuto...",
        "imagen": "https://picsum.photos/400/200",
        "fecha": DateTime(2025, 4, 25),
      },
      {
        "titulo": "Nuevos entrenamientos",
        "descripcion": "Inscripciones abiertas para verano.",
        "contenido":
        "Desde el 1 de junio comenzamos la preparación para la próxima temporada. Inscríbete ya y forma parte de la familia CDE Amistad.",
        "imagen": "https://picsum.photos/400/200",
        "fecha": DateTime(2025, 4, 20),
      },
      {
        "titulo": "Fiesta del Club",
        "descripcion": "No te pierdas nuestra gran fiesta familiar.",
        "contenido":
        "Este sábado a las 18:00h te esperamos en las instalaciones del club para disfrutar juntos de una jornada inolvidable.",
        "imagen": "https://picsum.photos/400/200",
        "fecha": DateTime(2025, 4, 18),
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
        preferredSize: const Size.fromHeight(80),
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
                  ...noticiasMock.map((noticia) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoticiaEntity(
                            titulo: noticia['titulo']!,
                            contenido: noticia['contenido']!,
                            imagen: noticia['imagen']!,
                            fecha: noticia['fecha']!,
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(noticia['descripcion']!),
                            const SizedBox(height: 4),
                            Text(
                              '📅 ${noticia['fecha'].day}/${noticia['fecha'].month}/${noticia['fecha'].year}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        trailing:
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  )),
                  const SizedBox(height: 30),
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
                        return GestureDetector(
                          onTap: () {
                            final fechaEvento = parseFecha(evento['fecha']!);
                            final event = buildEvent(
                              evento['titulo']!,
                              evento['lugar']!,
                              fechaEvento,
                            );

                            print("Fecha del evento a añadir: ${event.startDate}");

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Añadir a calendario'),
                                content: Text(
                                    '¿Quieres añadir "${evento['titulo']}" a tu calendario?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Add2Calendar.addEvent2Cal(event);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Añadir'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
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
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icono.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Meter frase a elegir",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
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