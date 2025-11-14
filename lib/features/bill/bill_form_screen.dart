import 'package:flutter/material.dart';

import '../../shared/app_scaffold.dart';

class BillFormScreen extends StatefulWidget {
  const BillFormScreen({super.key});

  @override
  State<BillFormScreen> createState() => _BillFormScreenState();
}

class _BillFormScreenState extends State<BillFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController totalController = TextEditingController();

  List<Participant> participants = [];

  void addParticipant() {
    setState(() {
      participants.add(Participant());
    });
  }

  void removeParticipant(int index) {
    setState(() {
      participants.removeAt(index);
    });
  }

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    // Here you will navigate to the next step (item split or summary)
    // Replace with your GoRouter navigation later
    print("Cuenta: ${titleController.text}");
    print("Total: ${totalController.text}");
    for (var p in participants) {
      print("Participante: ${p.name}, monto: ${p.amount}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Nueva división",
      bottomButtonContent: const Text(
        "Guardar",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // TITLE
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Nombre de la cuenta",
                hintText: "Ej: Cena con amigos",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Ingresa un nombre válido";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // PARTICIPANTS SECTION (EXPANDS)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Participantes",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: addParticipant,
                        child: const Text("Agregar"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Dynamic list – scrollable, fills available space
                  Expanded(
                    child: participants.isEmpty
                        ? Center(
                            child: Text(
                              "No hay participantes agregados todavía.",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: participants.length,
                            itemBuilder: (context, index) {
                              final p = participants[index];

                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: p.nameController,
                                        decoration: const InputDecoration(
                                          labelText: "Nombre",
                                          hintText: "Ej: Gabriel",
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Ingresa un nombre";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: p.amountController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: "Monto (opcional)",
                                          hintText:
                                              "Si lo dejas vacío, se dividirá equitativamente",
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          onPressed: () =>
                                              removeParticipant(index),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),

            // BOTTOM FIXED SECTION
            TextFormField(
              controller: totalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Monto total",
                prefixIcon: Icon(Icons.euro),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Ingresa el monto total";
                }
                if (double.tryParse(value) == null) {
                  return "Monto inválido";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class Participant {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String get name => nameController.text.trim();
  String get amount => amountController.text.trim();
}
