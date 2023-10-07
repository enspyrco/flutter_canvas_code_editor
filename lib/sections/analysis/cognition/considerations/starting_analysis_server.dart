import 'dart:io';

import 'package:abstractions/beliefs.dart';
import 'package:intl/intl.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:lsp_client/lsp_client.dart';
import 'package:path/path.dart';

import '../../../../subsystems/analysis_subystem.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../conclusions/analysis_updated.dart';

class StartingAnalysisServer extends Consideration<IDEBeliefs> {
  const StartingAnalysisServer({required Directory directory})
      : _directory = directory;

  final Directory _directory;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final analysisSystem = locate<AnalysisSubystem>();

    final initializeParams = InitializeParams(
      rootUri: _directory.uri,
      capabilities: ClientCapabilities(),
      initializationOptions: {},
      trace: const TraceValues.fromJson('verbose'),
      workspaceFolders: [
        WorkspaceFolder(
          name: basename(_directory.path),
          uri: _directory.uri,
        )
      ],
      clientInfo:
          InitializeParamsClientInfo(name: 'enspyr.co', version: '0.0.1'),
      locale: Intl.getCurrentLocale(),
    );

    await analysisSystem.startServer(initializeParams);

    beliefSystem.conclude(
      AnalysisUpdated(
        newSentMessage: {
          'method': 'initialize',
          'params': initializeParams.toJson(),
        },
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'StartingAnalysisServer',
        'state_': <String, Object?>{},
      };
}
