import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    var amountFormater = NumberFormat.currency(
      locale: 'es_ES',
      symbol: '\$',
      decimalDigits: 2,
    );

    var formatedSubtotal = amountFormater.format(widget.participant?.subtotal);
    var formatedTotal = widget.shares.containsKey(widget.participant?.name)
        ? amountFormater.format(widget.shares[widget.participant?.name]!)
        : '';
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: ListTile(
                        title: Text(
                          widget.participant?.name ?? '',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        // subtitle: Text('Subtotal: $formatedSubtotal'),
                      ),
                    ),
                    IconButton(
                      onPressed: _editPerson,
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(riverpodPersonList)
                            .removeParticipant(widget.index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Text(
                    'Total final: $formatedTotal',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
