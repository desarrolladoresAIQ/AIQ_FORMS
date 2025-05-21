import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'derrames.dart'; // Asegúrate de tener este archivo creado con el widget DerramesScreen

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final List<Map<String, String>> formularios = const [
    {
      "titulo": "NEUTRALIZACION Y LIMPIEZA DE DERRAMES",
      "codigo": "AIQ-F013-OPS",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "VERIFICACION CONTINUA",
      "codigo": "AIQ-OPS-F008",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "VERIFICACION PARA LA INSPECCION DIARIA",
      "codigo": "AIQ-OPS-F007",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "ARRIBA EL AIQ",
      "codigo": "AIQ-F015-INS",
      "imagen": "assets/derrames_form.png",
    },
    {
      "titulo": "PREVENCION DE INCURSIONES EN EL ÁREA DE MOVIMIENTO",
      "codigo": "AIQ-OPS-F005",
      "imagen": "assets/AIQ_LOGO.png",
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // Fondo decorativo
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

          // Botón de retroceso
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
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: Color(0xFF103A63),
                ),
              ),
            ),
          ),

          // Título
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

          // Carrusel
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: formularios.length,
                  options: CarouselOptions(
                    height: 400,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final form = formularios[index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DerramesScreen()),
                          );
                        }
                        // Puedes agregar más condiciones para otros formularios aquí.
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          form["imagen"]!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 260, // Ajusta la altura si lo deseas
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10), // <-- antes era 40

                // Indicadores
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(formularios.length, (index) {
                    return Container(
                      width: 10,
                      height: 20,
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
                // Footer TBIB
                const SizedBox(height: 24),
                const Text(
                  "TBIB",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
