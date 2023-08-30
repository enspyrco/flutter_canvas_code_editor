import 'package:flutter/material.dart';

import 'sections/i_d_e/i_d_e_screen.dart';
import 'priors.dart';

void main() async {
  await setupPriors(initialScreen: const IDEScreen());
  runApp(const MaterialApp(home: OriginOfPerception()));
}
