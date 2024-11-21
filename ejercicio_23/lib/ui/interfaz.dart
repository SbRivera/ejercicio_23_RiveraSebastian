import 'package:flutter/material.dart';

class PaginaInterfazEdad extends StatefulWidget {
  @override
  _InterfazEdadState createState() => _InterfazEdadState();
}

class _InterfazEdadState extends State<PaginaInterfazEdad> {
  List<int> edades = List.filled(10, 0);
  int currentIndex = 0;
  final _controller = TextEditingController();
  String result = '';
  String errorMessage = '';

  // Función para calcular los porcentajes
  void calcularPorcentaje() {
    int adultos = 0;
    int menores = 0;

    // Calcular cuántos adultos y menores hay
    for (var edad in edades) {
      if (edad >= 18) {
        adultos++;
      } else {
        menores++;
      }
    }

    // Calcular los porcentajes
    double porcentajeAdultos = (adultos / edades.length) * 100;
    double porcentajeMenores = (menores / edades.length) * 100;

    setState(() {
      result = 'Porcentaje de mayores de edad: ${porcentajeAdultos.toStringAsFixed(2)}%\n'
          'Porcentaje de menores de edad: ${porcentajeMenores.toStringAsFixed(2)}%';
      errorMessage = ''; // Limpiar cualquier mensaje de error después del cálculo
    });
  }

  // Función para ingresar una edad
  void ingresarEdad() {
    if (_controller.text.isNotEmpty) {
      String input = _controller.text.trim();
      if (RegExp(r'^[0-9]+$').hasMatch(input)) {
        setState(() {
          edades[currentIndex] = int.parse(input);
          if (currentIndex < 9) {
            currentIndex++; // Pasar al siguiente campo
          } else {
            calcularPorcentaje();
          }
          _controller.clear();
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Por favor ingresa un número entero positivo válido.';
        });
      }
    }
  }

  // Función para reiniciar el formulario y empezar desde el inicio
  void reiniciarFormulario() {
    setState(() {
      edades = List.filled(10, 0);
      currentIndex = 0;
      result = '';
      errorMessage = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Azul marino para el AppBar
        title: Text(
          'Calculadora de Porcentaje de Edad',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0), // Espaciado adecuado
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrando todo en la pantalla
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Ingresa las edades de las personas (uno por uno):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                textAlign: TextAlign.center, // Alineación centrada
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Edad ${currentIndex + 1}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => ingresarEdad(), // Al presionar "Enter" o "Hecho"
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ingresarEdad,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  currentIndex < 9 ? 'Ingresar Edad' : 'Calcular Porcentajes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              // Resultado
              if (result.isNotEmpty)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Edades ingresadas:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: List.generate(currentIndex, (index) {
                  return Chip(
                    label: Text(edades[index].toString(), style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blueAccent,
                  );
                }),
              ),
              // Botón para reiniciar el formulario
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: reiniciarFormulario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Reiniciar Edades',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
