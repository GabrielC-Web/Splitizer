import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final List<String> bills; // Lista de títulos de cuentas anteriores

  const HomeScreen({super.key, this.bills = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splitizer'),
        centerTitle: true,
      ),
      body: bills.isEmpty
          ? const Center(
        child: Text(
          'Aún no tienes cuentas registradas.\n¡Crea una nueva para comenzar!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bills[index]),
            leading: const Icon(Icons.receipt_long),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Ir a detalle de la cuenta seleccionada
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Abrir cuenta: ${bills[index]}')),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Cuenta nueva'),
        onPressed: () {
          // Navegar a la pantalla de nueva cuenta
          context.push('/bill');
        },
      ),
    );
  }
}
