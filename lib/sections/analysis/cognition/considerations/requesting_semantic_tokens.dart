import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../../../../systems/analysis_system.dart';
import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';
import '../conclusions/analysis_updated.dart';

class RequestingSemanticTokens extends Consideration<IDEBeliefs> {
  const RequestingSemanticTokens({required Uri fileUri}) : _fileUri = fileUri;

  final Uri _fileUri;

  @override
  Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
    final analysisSystem = locate<AnalysisSystem>();

    analysisSystem.requestSemanticTokens(_fileUri);

    beliefSystem.conclude(
      AnalysisUpdated(
        newSentMessage: {
          'method': 'textDocument/semanticTokens/full',
          'params': {'fileUri': _fileUri},
        },
      ),
    );
  }

  @override
  toJson() => {
        'name_': 'RequestingSemanticTokens',
        'state_': <String, Object?>{},
      };
}
