class CalculadoraEdades {
  static double calcularPorcentajeAdultos(List<int> edades) {
    int adultos = 0;
    for (var edad in edades) {
      if (edad >= 18) {
        adultos++;
      }
    }
    return (adultos / edades.length) * 100;
  }

  static double calcularPorcentajeMenores(List<int> edades) {
    int menores = 0;
    for (var edad in edades) {
      if (edad < 18) {
        menores++;
      }
    }
    return (menores / edades.length) * 100;
  }
}
