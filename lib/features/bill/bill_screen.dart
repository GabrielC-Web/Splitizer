import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitizer/features/bill/widgets/participant.dart';
import '../../core/state/riverpod.dart';
import '../../models/person.dart';
import '../../shared/app_scaffold.dart';
import 'dialogs/add_person_modal.dart';

class BillScreen extends ConsumerStatefulWidget {
  const BillScreen({super.key});

  @override
  ConsumerState<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends ConsumerState<BillScreen> {
  final TextEditingController _finalTotalController = TextEditingController();


  Map<String, double> get calculatedShares {
    final inputTotal = double.tryParse(_finalTotalController.text);
    if (inputTotal == null || ref.watch(riverpodPersonList).baseTotal == 0) return {};
    return {
      for (final p in ref.watch(riverpodPersonList).participants) p.name: ((p.subtotal / ref.watch(riverpodPersonList).baseTotal) * inputTotal),
    };
  }

  void _addPerson() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddPersonDialog(),
    );

    if (result != null) {
      final newParticipant = Participant(
        name: result['name'],
        purchases: List<double>.from(result['purchases']),
      );
      ref.read(riverpodPersonList).addParticipant(newParticipant);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shares = calculatedShares;

    return AppScaffold(
      title: 'Splitizer',
      showBack: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Participantes',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.person_add_alt),
                        label: const Text('Agregar'),
                        onPressed: _addPerson,
                      ),
                    ],
                  ),

                  ...ref.watch(riverpodPersonList).participants.asMap().entries.map(
                    (p) => ParticipantWidget(participant: p.value, shares: shares, index: p.key),
                  ),

                  const Divider(height: 32),

                  ListTile(
                    title: const Text('Total base de compras'),
                    trailing: Text('\$${ref.watch(riverpodPersonList).baseTotal.toStringAsFixed(2)}'),
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
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text('Reiniciar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
