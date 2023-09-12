import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../systems/analysis_system.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class StartingAnalysisServer extends Consideration<IDEBeliefs> {
  const StartingAnalysisServer();

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final service = locate<AnalysisSystem>();

    await service.startServer();

    // beliefSystem.conclude();
  }

  @override
  toJson() => {
        'name_': 'StartingAnalysisServer',
        'state_': <String, Object?>{},
      };
}
