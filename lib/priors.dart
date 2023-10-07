import 'dart:async';

import 'package:percepts/percepts.dart';
import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:introspection/introspection.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:framing_in_perception/framing_in_perception.dart';
import 'package:flutter/material.dart';
import 'package:abstractions/beliefs.dart';

import 'sections/analysis/cognition/considerations/listening_for_analysis.dart';
import 'sections/i_d_e/beliefs/i_d_e_beliefs.dart';
import 'sections/i_d_e/beliefs/i_d_e_layer.dart';
import 'systems/analysis_system.dart';
import 'systems/file_picker_system.dart';
import 'systems/file_system_subsystem.dart';
import 'systems/identity_system.dart';

Future<void> setupPriors({required Widget initialScreen}) async {
  // Setup Locator so plugins can add SystemChecks & Routes, configure the AppState, etc.
  Locator.add<Habits>(DefaultHabits());
  Locator.add<PageGenerator>(DefaultPageGenerator());
  Locator.add<IDEBeliefs>(IDEBeliefs.initial
      .copyWith(framing: const DefaultFramingBeliefs(layers: [IDELayer()])));

  // Add services
  Locator.add<FilePickerSystem>(const FilePickerSystem());
  Locator.add<FileSystemSubsystem>(const FileSystemSubsystem());
  Locator.add<IdentitySystem>(const IdentitySystem());
  Locator.add<AnalysisSystem>(AnalysisSystem());

  // Perform individual package initialization.
  initializeErrorHandling<IDEBeliefs>();
  initializeIntrospection<IDEBeliefs>();
  initializeFraming<IDEBeliefs>(
    (
      layerType: IDELayer,
      pageGenerator: (_) => MaterialPage(child: initialScreen),
    ),
  );

  /// Finally, create our BeliefSystem and add to the Locator.
  final beliefSystem = DefaultBeliefSystem<IDEBeliefs>(
      beliefs: locate<IDEBeliefs>(),
      errorHandlers: DefaultErrorHandlers<IDEBeliefs>(),
      habits: locate<Habits>(),
      beliefSystemFactory: ParentingBeliefSystem.new);

  Locator.add<BeliefSystem<IDEBeliefs>>(beliefSystem);
}

class OriginOfPerception extends StatelessWidget {
  const OriginOfPerception({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (const bool.fromEnvironment('IN-APP-INTROSPECTION'))
          Expanded(
            flex: 1,
            child: Material(
              child: IntrospectionScreen(locate<IntrospectionHabit>().stream),
            ),
          ),
        Expanded(
          flex: 1,
          child: FramingBuilder<IDEBeliefs>(
            onInit: (beliefSystem) {
              beliefSystem.consider(const ListeningForAnalysis());
            },
          ),
        ),
      ],
    );
  }
}
