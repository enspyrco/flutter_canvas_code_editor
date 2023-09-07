import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../services/analysis_service.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class StartingAnalysisServer extends Consideration<IDEBeliefs> {
  const StartingAnalysisServer();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final service = locate<AnalysisService>();

    await service.startServer();

    // beliefSystem.conclude();
  }

  @override
  toJson() => {
        'name_': 'StartAnalysisServer',
        'state_': <String, Object?>{},
      };
}
