import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
      title: Center(
        child: Text(
          'Participante',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth:
              double.maxFinite, // Forces content to take max available width
        ),
        child: Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Agregar compra:',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextField(
                    controller: purchaseNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  TextField(
                    controller: purchaseAmountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: const InputDecoration(labelText: 'Monto'),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: FloatingActionButton.extended(
                        onPressed: _addPurchase,
                        label: const Text('Agregar'),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (purchases.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Compras:',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
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
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
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
              child: Text(
                'Guardar',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
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
    var amountFormater = NumberFormat.currency(
      locale: 'es_ES',
      symbol: '\$',
      decimalDigits: 2,
    );

    var formatedAmount = amountFormater.format(p.amount);

    return Chip(
      // label: Text('${p.item} - \$${p.amount.toStringAsFixed(2)}'),
      label: Text('${p.item} - $formatedAmount'),
      deleteIcon: Icon(Icons.delete),
      onDeleted: removeItem,
    );
  }
}
