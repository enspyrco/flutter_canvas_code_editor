import 'dart:io';

import 'package:abstractions/beliefs.dart';
import 'package:intl/intl.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:lsp_client/lsp_client.dart';
import 'package:path/path.dart';

import '../../../../systems/analysis_system.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../conclusions/analysis_updated.dart';

class StartingAnalysisServer extends Consideration<IDEBeliefs> {
  const StartingAnalysisServer();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final service = locate<AnalysisSystem>();

    final initializeParams = InitializeParams(
      rootUri: Directory.current.uri,
      capabilities: ClientCapabilities(),
      initializationOptions: {},
      trace: const TraceValues.fromJson('verbose'),
      workspaceFolders: [
        WorkspaceFolder(
          name: basename(Directory.current.path),
          uri: Directory.current.uri,
        )
      ],
      clientInfo:
          InitializeParamsClientInfo(name: 'enspyr.co', version: '0.0.1'),
      locale: Intl.getCurrentLocale(),
    );

    await service.startServer(initializeParams);

    beliefSystem.conclude(
      AnalysisUpdated(
        newSentMessage: {
          'method': 'initialized',
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
