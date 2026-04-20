class Gasto {
  final String nombre;
  final double monto;
  final String categoria;
  final String descripcion;
  final DateTime fechaRegistro;

  Gasto({
    required this.nombre,
    required this.monto,
    required this.categoria,
    this.descripcion = '',
    DateTime? fechaRegistro,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  Gasto copyWith({
    String? nombre,
    double? monto,
    String? categoria,
    String? descripcion,
    DateTime? fechaRegistro,
  }) {
    return Gasto(
      nombre: nombre ?? this.nombre,
      monto: monto ?? this.monto,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    );
  }
}