import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitizer/core/state/riverpod.dart';
import 'package:splitizer/models/person.dart';

class AddPersonDialog extends ConsumerStatefulWidget {

  final int? index;

  const AddPersonDialog({super.key, this.index});

  @override
  ConsumerState<AddPersonDialog> createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends ConsumerState<AddPersonDialog> {
  var nameController = TextEditingController();
  var purchaseNameController = TextEditingController();
  var purchaseAmountController = TextEditingController();
  late List<double> purchases = [];

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
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      if(widget.index != null) {
        print('loaded ${ref.read(riverpodPersonList).participants[widget.index as int].name}');
        nameController = TextEditingController(text: ref.read(riverpodPersonList).participants[widget.index as int].name.toString());
        purchases.clear();
        purchases.addAll([...ref.read(riverpodPersonList).participants[widget.index as int].purchases]);
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

            //* edit
            if(widget.index != null) {
              ref.read(riverpodPersonList).editParticipant(widget.index!, Participant.fromMap({
                'name': nameController.text,
                'purchases': purchases,
              }));
              Navigator.pop(context);
              return;
            }

            //* Add
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
