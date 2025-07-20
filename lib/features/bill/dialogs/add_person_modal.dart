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
  late TextEditingController nameController;
  late TextEditingController purchaseNameController;
  late TextEditingController purchaseAmountController;
  late List<Purchase> purchases = [];

  void _addPurchase() {
    final value = double.tryParse(purchaseAmountController.text);
    print('met $value');
    if (value != null) {
      setState(() {
        purchases.add(
          Purchase.fromMap({
            'item': purchaseNameController.text,
            'amount': value,
          }),
        );
        purchaseNameController.clear();
        purchaseAmountController.clear();
      });
    }
  }

  void _removePurchase(int index) {
    setState(() {
      purchases.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    purchaseNameController = TextEditingController();
    purchaseAmountController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.index != null) {
      print(
        'loaded ${ref.read(riverpodPersonList).participants[widget.index as int].name}',
      );
      nameController = TextEditingController(
        text: ref
            .read(riverpodPersonList)
            .participants[widget.index as int]
            .name
            .toString(),
      );
      purchases.clear();
      purchases.addAll([
        ...ref
            .read(riverpodPersonList)
            .participants[widget.index as int]
            .purchases,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: const Text('Participante')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            Center(child: Text('Compras')),
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
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: purchaseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Monto'),
                  ),
                ),
                IconButton(
                  onPressed: _addPurchase,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (purchases.isNotEmpty)
              Wrap(
                spacing: 8,
                children: purchases
                    .asMap()
                    .entries
                    .map(
                      (p) => PurchaseItem(
                        p: p.value,
                        removeItem: () => _removePurchase(p.key),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                //* edit
                if (widget.index != null) {
                  ref
                      .read(riverpodPersonList)
                      .editParticipant(
                        widget.index!,
                        Participant.fromMap({
                          'name': nameController.text,
                          'purchases': purchases,
                        }),
                      );
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
        ),
      ],
    );
  }
}

class PurchaseItem extends StatelessWidget {
  final Purchase p;
  final VoidCallback removeItem;

  const PurchaseItem({super.key, required this.p, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Chip(
        label: Text('${p.item} - \$${p.amount.toStringAsFixed(2)}'),
        deleteIcon: Icon(Icons.delete),
        onDeleted: removeItem,
      ),
    );
  }
}
