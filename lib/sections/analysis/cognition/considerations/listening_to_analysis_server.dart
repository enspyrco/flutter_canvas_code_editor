import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:lsp_client/lsp_client.dart';

import '../../../../systems/analysis_system.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../conclusions/analysis_update.dart';

class ListeningToAnalysisServer extends Consideration<IDEBeliefs> {
  const ListeningToAnalysisServer();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final service = locate<AnalysisSystem>();

    await for (Map<String, Object?> message in service.onJsonFromServer) {
      // when the analysis server sends a response to the 'initialize' request,
      // we need to send it an 'initialized' notification before we start
      // using it.
      if (message['id'] == AnalysisProcess.initialize.index) {
        service.declareServerInitialized();
        beliefSystem.conclude(const AnalysisUpdate(initialized: true));
      }

      beliefSystem.conclude(
        AnalysisUpdate(newReceivedMessage: message),
      );
    }
  }

  @override
  toJson() => {
        'name_': 'ListeningToAnalysisServer',
        'state_': <String, Object?>{},
      };
}
