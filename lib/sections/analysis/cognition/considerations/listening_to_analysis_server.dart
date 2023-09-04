import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../../services/analysis_server_service.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../conclusions/analysis_update.dart';

class ListeningToAnalysisServer extends Consideration<IDEBeliefs> {
  const ListeningToAnalysisServer();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final service = locate<AnalysisServerService>();

    await for (String message in service.getReceiveStream()) {
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
