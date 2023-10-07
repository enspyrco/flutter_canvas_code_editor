import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:lsp_client/lsp_client.dart';

import '../../../../subsystems/analysis_subystem.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../conclusions/analysis_updated.dart';

class ListeningForAnalysis extends Consideration<IDEBeliefs> {
  const ListeningForAnalysis();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final analysisSystem = locate<AnalysisSubystem>();

    await for (Map<String, Object?> message
        in analysisSystem.onJsonFromServer) {
      // when the analysis server sends a response to the 'initialize' request,
      // we need to send it an 'initialized' notification before we start
      // using it.
      if (message['id'] == AnalysisProcess.initialize.index) {
        analysisSystem.declareServerInitialized();
        beliefSystem.conclude(
          const AnalysisUpdated(
            initialized: true,
            newSentMessage: {
              'method': 'initialized',
              'params': {},
            },
          ),
        );
      }

      message.remove('jsonrpc'); // this is redundant and just takes up space
      beliefSystem.conclude(
        AnalysisUpdated(newReceivedMessage: message),
      );
    }
  }

  @override
  toJson() => {
        'name_': 'ListeningForAnalysis',
        'state_': <String, Object?>{},
      };
}
