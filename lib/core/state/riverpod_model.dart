import 'package:flutter/material.dart';

import '../../models/person.dart';

class RiverpodModel extends ChangeNotifier {
  List<Participant> participants;

  double get baseTotal => participants.fold(0.0, (sum, p) => sum + p.subtotal);

  RiverpodModel({required this.participants});
  void addParticipant(Participant participant) {
    participants.add(participant);
    print('participants: ${participants.toList()}');
    notifyListeners();
  }

  void removeParticipant(int index) {
    participants.removeAt(index);
    notifyListeners();
  }

  void editParticipant(int index, Participant participant) {
    participants[index] = participant;
    notifyListeners();
  }

  void reset() {
    participants.clear();
    notifyListeners();
  }

  // int calculateFinalShares() {
  //   Map<String, double> get calculatedShares {
  //     final inputTotal = double.tryParse(_finalTotalController.text);
  //     if (inputTotal == null || baseTotal == 0) return {};
  //     return {
  //       for (final p in _people) p.name: ((p.subtotal / baseTotal) * inputTotal),
  //     };
  //   }
  // }
}
