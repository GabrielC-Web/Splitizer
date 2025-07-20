import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitizer/core/state/riverpod.dart';
import 'package:splitizer/models/person.dart';

class AddPersonDialog extends ConsumerStatefulWidget {

  final int? index;
  final Participant? savedParticipant;

  const AddPersonDialog({super.key, this.index, this.savedParticipant});

  @override
  ConsumerState<AddPersonDialog> createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends ConsumerState<AddPersonDialog> {
  var nameController = TextEditingController();
  var purchaseNameController = TextEditingController();
  var purchaseAmountController = TextEditingController();
  List<double> purchases = [];

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
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.index != null && widget.savedParticipant != null) {
        print('loaded ${widget.savedParticipant!.purchases}');
        nameController = TextEditingController(text: widget.savedParticipant?.name.toString());
        purchases.clear();
        purchases.addAll([...widget.savedParticipant!.purchases]);
      }
    });

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
            if(widget.index != null && widget.savedParticipant != null) {
              ref.read(riverpodPersonList).editParticipant(widget.index!, {
                'name': nameController.text,
                'purchases': purchases,
              } as Participant);
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
