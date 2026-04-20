import 'package:flutter/foundation.dart';
import '../models/gasto.dart';

class GastosViewModel extends ChangeNotifier {
  final List<Gasto> _gastos = [];

  List<Gasto> get gastos => List.unmodifiable(_gastos);

  bool get isEmpty => _gastos.isEmpty;

  double get totalGeneral =>
      _gastos.fold(0.0, (suma, g) => suma + g.monto);

  Map<String, double> get totalPorCategoria {
    final Map<String, double> totales = {};
    for (final g in _gastos) {
      totales[g.categoria] = (totales[g.categoria] ?? 0.0) + g.monto;
    }
    return totales;
  }

  void agregarGasto(Gasto gasto) {
    _gastos.add(gasto);
    notifyListeners();
  }
}