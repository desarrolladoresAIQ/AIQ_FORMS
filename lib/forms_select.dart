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
    },
    {
      "titulo": "MANTENIMIENTO",
      "codigo": "AIQ-F022-MAN",
    },
    {
      "titulo": "INSPECCIÓN DE EQUIPOS",
      "codigo": "AIQ-F015-INS",
    },
    {
      "titulo": "ARRIBA EL AIQ",
      "codigo": "AIQ-F015-INS",
    },
    {
      "titulo": "ARRIBA DIOS ABAJO EL DIABLO",
      "codigo": "AIQ-F015-INS",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // Imagen de fondo
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
            top: 40,
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

          // Carrusel en el centro
          Center(
            child: CarouselSlider.builder(
              itemCount: formularios.length,
              options: CarouselOptions(
                height: 500,
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              itemBuilder: (context, index, realIndex) {
                final form = formularios[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Seleccionaste: ${form["titulo"]}")),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.description_outlined,
                              size: 60, color: Color(0xFF103A63)),
                          const SizedBox(height: 20),
                          Text(
                            form["titulo"]!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            form["codigo"]!,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
