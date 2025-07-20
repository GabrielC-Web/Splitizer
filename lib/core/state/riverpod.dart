import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitizer/core/state/riverpod_model.dart';
import 'package:splitizer/models/person.dart';

final riverpodPersonList = ChangeNotifierProvider<RiverpodModel>((ref) {
  return RiverpodModel(participants: []);
});

// final riverpodHardLevel