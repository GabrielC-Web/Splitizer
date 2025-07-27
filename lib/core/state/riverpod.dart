import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitizer/core/state/riverpod_model.dart';

final riverpodPersonList = ChangeNotifierProvider<RiverpodModel>((ref) {
  return RiverpodModel(participants: []);
});

final riverpodThemeMode = ChangeNotifierProvider<RiverpodThemeModeModel>((ref) {
  return RiverpodThemeModeModel(themeMode: '');
});
