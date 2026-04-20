import 'package:flutter/material.dart';
import '../models/gasto.dart';

class DetalleScreen extends StatelessWidget {
  final Gasto gasto;
  const DetalleScreen({super.key, required this.gasto});

  @override
  Widget build(BuildContext context) {
    final f = gasto.fechaRegistro;
    final fecha =
        '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}  '
        '${f.hour.toString().padLeft(2, '0')}:${f.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Gasto'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.receipt_long,
                      size: 64, color: Colors.indigo),
                  const SizedBox(height: 8),
                  Text(
                    'S/. ${gasto.monto.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            _Fila(icono: Icons.label, titulo: 'Nombre', valor: gasto.nombre),
            const SizedBox(height: 16),
            _Fila(
                icono: Icons.category,
                titulo: 'Categoría',
                valor: gasto.categoria),
            const SizedBox(height: 16),
            _Fila(
              icono: Icons.notes,
              titulo: 'Descripción',
              valor: gasto.descripcion.trim().isEmpty
                  ? 'Sin descripción'
                  : gasto.descripcion,
              esSecundario: gasto.descripcion.trim().isEmpty,
            ),
            const SizedBox(height: 16),
            _Fila(
                icono: Icons.calendar_today,
                titulo: 'Fecha de registro',
                valor: fecha),
          ],
        ),
      ),
    );
  }
}

class _Fila extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;
  final bool esSecundario;

  const _Fila({
    required this.icono,
    required this.titulo,
    required this.valor,
    this.esSecundario = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icono, color: Colors.indigo, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black45)),
              const SizedBox(height: 2),
              Text(valor,
                  style: TextStyle(
                      fontSize: 16,
                      color:
                      esSecundario ? Colors.black38 : Colors.black87,
                      fontStyle: esSecundario
                          ? FontStyle.italic
                          : FontStyle.normal)),
            ],
          ),
        ),
      ],
    );
  }
}