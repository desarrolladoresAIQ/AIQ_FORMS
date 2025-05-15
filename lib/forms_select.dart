import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final List<Map<String, String>> formularios = const [
    {
      "titulo": "DERRAMES",
      "codigo": "AIQ-F013-OPS",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "MANTENIMIENTO",
      "codigo": "AIQ-F022-MAN",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "INSPECCIÓN DE EQUIPOS",
      "codigo": "AIQ-F015-INS",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "ARRIBA EL AIQ",
      "codigo": "AIQ-F015-INS",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "ARRIBA DIOS ABAJO EL DIABLO",
      "codigo": "AIQ-F015-INS",
      "imagen": "assets/AIQ_LOGO.png",
    },
  ];

  int _currentIndex = 0;  // Para el indicador de posición

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // Imagen del airbus
          Positioned(
            bottom: -180,
            left: -400,
            right: -130,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                "assets/airbus.png",
                height: 600,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          // Botón de retroceso "<" como texto
          Positioned(
            top: 80,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: const Text(
                  "<",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Impact',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF103A63),
                  ),
                ),
              ),
            ),
          ),

          // Título "ESCOGE UN\nFORMULARIO"
          Positioned(
            top: 80,
            left: 60,
            right: 50,
            child: RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "ESCOGE UN\n",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Avenir',
                      color: Color(0xFF263A5B),
                    ),
                  ),
                  TextSpan(
                    text: "FORMULARIO",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Avenir',
                      color: Color(0xFF598CBC),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Carrusel en el centro con imágenes sin recorte
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: formularios.length,
                  options: CarouselOptions(
                    height: 300,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    aspectRatio: 30 / 9,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  // Dentro del CarouselSlider.builder, cambia el itemBuilder a esto:

itemBuilder: (context, index, realIndex) {
  final form = formularios[index];
  return InkWell(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Seleccionaste: ${form["titulo"]}"),
        ),
      );
    },
    child: Container(
      // Aumentamos el tamaño del contenedor para que quepa toda la imagen
      width: double.infinity,
      height: 100, // Más alto para que la imagen no se recorte
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0), // Sin bordes redondeados
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            form["imagen"]!,
            fit: BoxFit.contain, // Cambiado a contain para que se vea completa
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  form["titulo"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  form["codigo"]!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
},

                ),
                const SizedBox(height: 20),

                // Dots indicadores
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(formularios.length, (index) {
                    return Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? const Color(0xFF103A63)
                            : Colors.grey[300],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
