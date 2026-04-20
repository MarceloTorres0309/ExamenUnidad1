import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gastos_view_model.dart';
import '../models/gasto.dart';
import 'registro_screen.dart';
import 'detalle_screen.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Gastos'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Consumer<GastosViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: [
              _ResumenTotales(viewModel: viewModel),
              Expanded(
                child: viewModel.isEmpty
                    ? _EstadoVacio()
                    : _ListaGastos(gastos: viewModel.gastos),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RegistroScreen()),
          );
        },
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        tooltip: 'Agregar gasto',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ResumenTotales extends StatelessWidget {
  final GastosViewModel viewModel;
  const _ResumenTotales({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final totalesCat = viewModel.totalPorCategoria;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.indigo.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total acumulado',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              Text(
                'S/. ${viewModel.totalGeneral.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ],
          ),
          if (totalesCat.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Divider(),
            const Text('Por categoría',
                style: TextStyle(fontSize: 12, color: Colors.black45)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: totalesCat.entries.map((e) {
                return Chip(
                  label: Text('${e.key}: S/. ${e.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 11)),
                  backgroundColor: Colors.indigo.shade100,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _EstadoVacio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.savings_outlined, size: 80, color: Colors.indigo.shade200),
          const SizedBox(height: 16),
          const Text('No hay gastos registrados',
              style: TextStyle(fontSize: 18, color: Colors.black54)),
          const SizedBox(height: 8),
          const Text('Toca el botón + para agregar tu primer gasto',
              style: TextStyle(fontSize: 14, color: Colors.black38)),
        ],
      ),
    );
  }
}

class _ListaGastos extends StatelessWidget {
  final List<Gasto> gastos;
  const _ListaGastos({required this.gastos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: gastos.length,
      itemBuilder: (context, index) {
        final gasto = gastos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: const Icon(Icons.receipt_long, color: Colors.indigo),
            ),
            title: Text(gasto.nombre,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(gasto.categoria),
            trailing: Text(
              'S/. ${gasto.monto.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DetalleScreen(gasto: gasto)),
              );
            },
          ),
        );
      },
    );
  }
}