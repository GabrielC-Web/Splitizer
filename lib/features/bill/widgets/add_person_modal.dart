import 'package:flutter/material.dart';

class AddPersonDialog extends StatefulWidget {
  const AddPersonDialog({super.key});

  @override
  State<AddPersonDialog> createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends State<AddPersonDialog> {
  final nameController = TextEditingController();
  final purchaseNameController = TextEditingController();
  final purchaseAmountController = TextEditingController();
  final List<double> purchases = [];

  void _addPurchase() {
    final value = double.tryParse(purchaseAmountController.text);
    print('met $value');
    if (value != null) {
      setState(() {
        purchases.add(value);
        purchaseNameController.clear();
        purchaseAmountController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar participante'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: purchaseNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Item'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: purchaseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Monto'),
                  ),
                ),
                IconButton(onPressed: _addPurchase, icon: const Icon(Icons.add))
              ],
            ),
            const SizedBox(height: 16),
            if (purchases.isNotEmpty)
              Wrap(
                spacing: 8,
                children: purchases
                    .map((p) => Chip(label: Text('\$${p.toStringAsFixed(2)}')))
                    .toList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            print('met ${nameController.text.isNotEmpty && purchases.isNotEmpty}');
            if (nameController.text.isNotEmpty && purchases.isNotEmpty) {
              Navigator.pop(context, {
                'name': nameController.text,
                'purchases': purchases,
              });
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
