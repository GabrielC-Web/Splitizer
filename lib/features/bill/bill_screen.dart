import 'package:flutter/material.dart';
import '../../shared/app_scaffold.dart';
import 'widgets/add_person_modal.dart';

class Person {
  final String name;
  final List<double> purchases;

  Person({required this.name, this.purchases = const []});

  double get subtotal => purchases.fold(0.0, (sum, item) => sum + item);
}

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _finalTotalController = TextEditingController();

  final List<Person> _people = [];

  double get baseTotal =>
      _people.fold(0.0, (sum, p) => sum + p.subtotal);

  Map<String, double> get calculatedShares {
    final inputTotal = double.tryParse(_finalTotalController.text);
    if (inputTotal == null || baseTotal == 0) return {};
    return {
      for (final p in _people)
        p.name: ((p.subtotal / baseTotal) * inputTotal)
    };
  }

  void _addPerson() async {
    print('hello');
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddPersonDialog(),
    );

    print('aver $result');

    if (result != null) {
      final newPerson = Person(
        name: result['name'],
        purchases: List<double>.from(result['purchases']),
      );
      setState(() => _people.add(newPerson));
    }
  }

  @override
  Widget build(BuildContext context) {
    final shares = calculatedShares;

    return AppScaffold(title: 'Nueva Cuenta', child: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Título de la cuenta',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Participantes', style: TextStyle(fontSize: 18)),
              TextButton.icon(
                icon: const Icon(Icons.person_add_alt),
                label: const Text('Agregar'),
                onPressed: _addPerson,
              ),
            ],
          ),

          ..._people.map((p) => ListTile(
            title: Text(p.name),
            subtitle: Text('Subtotal: \$${p.subtotal.toStringAsFixed(2)}'),
            trailing: shares.containsKey(p.name)
                ? Text('\$${shares[p.name]!.toStringAsFixed(2)}')
                : null,
          )),

          const Divider(height: 32),

          ListTile(
            title: const Text('Total base de compras'),
            trailing: Text('\$${baseTotal.toStringAsFixed(2)}'),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _finalTotalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Monto total en la cuenta (con impuestos)',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      )));
  }
}
