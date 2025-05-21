import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class DerramesScreen extends StatefulWidget {
  const DerramesScreen({super.key});

  @override
  State<DerramesScreen> createState() => _DerramesScreenState();
}

class _DerramesScreenState extends State<DerramesScreen> {
  double criticidad = 0; //1.5 para que comience en el medio
  int tiempoMinutos = 0;
  int areaAfectada = 0;
  int folio = 1; // Preguntar en que folio van y cambiar el 1 para da seguimiento
  String fechaHoy = "${DateTime.now().day.toString().padLeft(2, '0')}/"
      "${DateTime.now().month.toString().padLeft(2, '0')}/"
      "${DateTime.now().year}";

  final List<String> materiales = [
    "Espuma Contra Incendio",
    "Material Absorbente",
    "Líquido Desengrasante",
    "Agua",
  ];
  final List<int> cantidades = [0, 0, 0, 0];
  final Set<int> seleccionados = {};
  final TextEditingController tiempoController = TextEditingController();
  TimeOfDay? tiempoSeleccionado;
  String? ubicacionSeleccionada;
  TextEditingController especificarUbicacionController = TextEditingController();
  String? productoSeleccionado;
  TextEditingController especificarProductoController = TextEditingController();

  final SignatureController firma1Controller = SignatureController(penStrokeWidth: 2, penColor: Color(0xFF263A5B));
  final SignatureController firma2Controller = SignatureController(penStrokeWidth: 2, penColor: Color(0xFF263A5B));
  final SignatureController firma3Controller = SignatureController(penStrokeWidth: 2, penColor: Color(0xFF263A5B));

  Color getSliderColor(double value) {
    if (value <= 1.5) {
      // Verde a amarillo
      return Color.lerp(Colors.green, Colors.yellow, value / 1.5)!;
    } else {
      // Amarillo a rojo
      return Color.lerp(Colors.yellow, Colors.red, (value - 1.5) / 1.5)!;
    }
  }

  @override
  void dispose() {
    firma1Controller.dispose();
    firma2Controller.dispose();
    firma3Controller.dispose();
    tiempoController.dispose();
    especificarUbicacionController.dispose();
    especificarProductoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sliderColor = getSliderColor(criticidad);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFE8EAF2),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: const Color(0xFF263A5B),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "NEUTRALIZACION Y LIMPIEZA\n",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Avenir',
                            color: Color(0xFF263A5B),
                          ),
                        ),
                        TextSpan(
                          text: "DE DERRAMES",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Avenir',
                            color: Color(0xFF598CBC),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Text(
                  "AIQ-SMS-F013",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF263A5B),
                    fontFamily: 'Avenir',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Datos de notificación
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Datos de Notificación",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Avenir',
                          color: Color(0xFF263A5B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Folio: $folio",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          Text(
                            "Fecha: $fechaHoy",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      //Fecha y hora de notificacion
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: TextField(
                                cursorColor: const Color(0xFF263A5B),
                                style: const TextStyle(color: Color(0xFF263A5B)),
                                decoration: const InputDecoration(
                                  labelText: "Fecha/Hora de Notificación",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  icon: Icon(Icons.calendar_today, color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),

                          //Hora de llegada al lugar
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  const Icon(Icons.access_time, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Horas",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xFF263A5B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(":", style: TextStyle(fontSize: 18, color: Color(0xFF263A5B))),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Min",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xFF263A5B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      

                      //Nombre de quien notifica
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          cursorColor: const Color(0xFF263A5B),
                          style: const TextStyle(color: Color(0xFF263A5B)),
                          decoration: const InputDecoration(
                            labelText: "Nombre de quien notifica",
                            labelStyle: TextStyle(color: Colors.grey),
                            icon: Icon(Icons.person, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                // Ubicación del derrame
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ubicacion de Derrame",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Avenir',
                          color: Color(0xFF263A5B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonFormField<String>(
                          value: ubicacionSeleccionada,
                          decoration: const InputDecoration(
                            labelText: "Ubicación del Derrame",
                            labelStyle: TextStyle(color: Colors.grey),
                            icon: Icon(Icons.location_on, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          items: ['Plataforma', 'Pista', 'Rodaje', 'Otro']
                              .map((opcion) => DropdownMenuItem(
                                    value: opcion,
                                    child: Text(opcion),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              ubicacionSeleccionada = value;
                            });
                          },
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Color(0xFF263A5B)),
                        ),
                      ),
                      if (ubicacionSeleccionada == 'Otro')
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              controller: especificarUbicacionController,
                              cursorColor: const Color(0xFF263A5B),
                              style: const TextStyle(color: Color(0xFF263A5B)),
                              decoration: const InputDecoration(
                                labelText: "Especifique",
                                labelStyle: TextStyle(color: Colors.grey),
                                icon: Icon(Icons.edit_location_alt, color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Datos del derrame con slider
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Datos del Derrame",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Avenir',
                          color: Color(0xFF263A5B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Criticidad",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: sliderColor,
                                inactiveTrackColor: sliderColor.withOpacity(0.3),
                                thumbColor: sliderColor,
                                overlayColor: Colors.transparent,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14, elevation: 4),
                                trackHeight: 8,
                              ),
                              child: Slider(
                                value: criticidad,
                                min: 0,
                                max: 3,
                                divisions: 3,
                                label: criticidad.toStringAsFixed(1),
                                onChanged: (value) {
                                  setState(() {
                                    criticidad = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Bajo", style: TextStyle(color: Colors.grey)),
                                  Text("Medio", style: TextStyle(color: Colors.grey)),
                                  Text("Alto", style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Campo: Líquido Derramado
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: productoSeleccionado,
                              decoration: const InputDecoration(
                                labelText: "Producto Derramado",
                                labelStyle: TextStyle(color: Colors.grey),
                                icon: Icon(Icons.water_drop_rounded, color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              items: [
                                'Combustible',
                                'Aceite',
                                'Agua',
                                'Otro',
                              ].map((opcion) => DropdownMenuItem(
                                    value: opcion,
                                    child: Text(opcion),
                                  )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  productoSeleccionado = value;
                                });
                              },
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Color(0xFF263A5B)),
                            ),
                            if (productoSeleccionado == 'Otro')
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: TextField(
                                    controller: especificarProductoController,
                                    cursorColor: const Color(0xFF263A5B),
                                    style: const TextStyle(color: Color(0xFF263A5B)),
                                    decoration: const InputDecoration(
                                      labelText: "Especifique",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      icon: Icon(Icons.edit, color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Campo: Originado por...
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const TextField(
                          cursorColor: Color(0xFF263A5B),
                          style: TextStyle(color: Color(0xFF263A5B)),
                          decoration: InputDecoration(
                            labelText: "Originado por...",
                            labelStyle: TextStyle(color: Colors.grey),
                            icon: Icon(Icons.airplanemode_active_rounded, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Alinea a la izquierda
                        children: [
                          Text(
                            "No. Vuelo",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 15, // Un poquito más grande
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "/",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Matrícula",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "/",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "No. Económico",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "/",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Compañía",
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const TextField(
                          cursorColor: Color(0xFF263A5B),
                          style: TextStyle(color: Color(0xFF263A5B)),
                          decoration: InputDecoration(
                            labelText: "Escriba la información aquí...",
                            labelStyle: TextStyle(
                              color: Color(0xFFB0B0B0),
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Material utilizado (LITROS) ---
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Material utilizado",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263A5B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      
                      // Títulos en una sola línea
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          materiales.length,
                          (index) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 4),
                              child: Text(
                                materiales[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF263A5B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 11),
                      // Contadores en una sola línea
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          materiales.length,
                          (index) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                height: 48,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "${cantidades[index]} ${index == 1 ? 'kg' : 'lt'}", // <-- Solo el segundo es kg
                                          style: const TextStyle(
                                            color: Color(0xFF263A5B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 28,
                                          height: 24,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            iconSize: 18,
                                            icon: const Icon(Icons.keyboard_arrow_up, color: Color(0xFF263A5B)),
                                            splashRadius: 16,
                                            onPressed: () {
                                              setState(() {
                                                cantidades[index]++;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 28,
                                          height: 24,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            iconSize: 18,
                                            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF263A5B)),
                                            splashRadius: 16,
                                            onPressed: () {
                                              setState(() {
                                                if (cantidades[index] > 0) cantidades[index]--;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Área afectada y tiempo empleado con títulos e íconos
                      Row(
                        children: [
                          // Área Afectada
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      Icon(Icons.square_foot, color: Color(0xFF263A5B), size: 18),
                                      SizedBox(width: 6),
                                      Text(
                                        "Área Afectada (m²)",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF263A5B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  height: 48,
                                  margin: const EdgeInsets.only(right: 8),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      hintText: "Ej: 10",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: const TextStyle(
                                      color: Color(0xFF263A5B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tiempo empleado (horas y minutos)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer, color: Color(0xFF263A5B), size: 18),
                                      SizedBox(width: 6),
                                      Text(
                                        "Tiempo empleado",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF263A5B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  height: 48,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                            hintText: "Horas",
                                            hintStyle: TextStyle(color: Colors.grey),
                                          ),
                                          style: const TextStyle(
                                            color: Color(0xFF263A5B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Text(":", style: TextStyle(fontSize: 18, color: Color(0xFF263A5B))),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                            hintText: "Min",
                                            hintStyle: TextStyle(color: Colors.grey),
                                          ),
                                          style: const TextStyle(
                                            color: Color(0xFF263A5B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9), // Fondo igual que los demás bloques
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.warning_amber_rounded, color: Color(0xFF263A5B), size: 20),
                          SizedBox(width: 6),
                          Text(
                            "Causa del derrame",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          maxLines: 2,
                          cursorColor: Color(0xFF263A5B),
                          style: TextStyle(color: Color(0xFF263A5B)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            hintText: "Describa brevemente la causa...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.groups_rounded, color: Color(0xFF263A5B), size: 20),
                          SizedBox(width: 6),
                          Text(
                            "Personal y vehículos que atienden",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          maxLines: 2,
                          cursorColor: Color(0xFF263A5B),
                          style: TextStyle(color: Color(0xFF263A5B)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            hintText: "Describa brevemente...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2C8D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.comment_rounded, color: Color(0xFF263A5B), size: 20),
                          SizedBox(width: 6),
                          Text(
                            "Observaciones / Comentarios",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          maxLines: 2,
                          cursorColor: Color(0xFF263A5B),
                          style: TextStyle(color: Color(0xFF263A5B)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            hintText: "Escriba aquí...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    // Firma Persona 1
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Firma Persona 1",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Signature(
                              controller: firma1Controller,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () => firma1Controller.clear(),
                            child: const Text("Limpiar", style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Firma Persona 2
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Firma Persona 2",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Signature(
                              controller: firma2Controller,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () => firma2Controller.clear(),
                            child: const Text("Limpiar", style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Firma Persona 3
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Firma Persona 3",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF263A5B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Signature(
                              controller: firma3Controller,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () => firma3Controller.clear(),
                            child: const Text("Limpiar", style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        folio++;
                        // Aquí tu lógica para guardar el formulario
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF598CBC),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "GUARDAR",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
        // Imagen en la esquina inferior derecha del logo del AIQ
        Positioned(
          bottom: 16,
          right: 16,
          child: Opacity(
            opacity: 0.85,
            child: Image.asset(
              'assets/AIQ_LOGO.png', 
              width: 100, // Ajustar el tamaño del logo del aiq
            ),
          ),
        ),
      ],
    );
  }
}