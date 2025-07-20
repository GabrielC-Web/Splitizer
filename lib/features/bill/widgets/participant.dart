import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/riverpod.dart';
import '../../../models/person.dart';
import '../dialogs/add_person_modal.dart';

class ParticipantWidget extends ConsumerStatefulWidget {
  final int index;
  final Participant? participant;
  final dynamic shares;

  const ParticipantWidget({
    super.key,
    required this.participant,
    required this.shares,
    required this.index,
  });

  @override
  ConsumerState<ParticipantWidget> createState() => _ParticipantWidgetState();
}

class _ParticipantWidgetState extends ConsumerState<ParticipantWidget> {
  void _editPerson() async {
    await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddPersonDialog(index: widget.index),
    );
  }

  @override
  void initState() {
    super.initState();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(widget.participant?.name ?? ''),
              subtitle: Text(
                'Subtotal: \$${widget.participant?.subtotal.toStringAsFixed(2)}',
              ),
              trailing: widget.shares.containsKey(widget.participant?.name)
                  ? Text(
                      'Total final: \$${widget.shares[widget.participant?.name]!.toStringAsFixed(2)}',
                    )
                  : null,
            ),
          ),
          IconButton(onPressed: _editPerson, icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () {
              ref.read(riverpodPersonList).removeParticipant(widget.index);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
