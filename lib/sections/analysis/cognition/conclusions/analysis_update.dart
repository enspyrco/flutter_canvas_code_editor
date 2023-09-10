import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class AnalysisUpdate extends Conclusion<IDEBeliefs> {
  const AnalysisUpdate({
    Map<String, Object?>? newReceivedMessage,
    bool? initialized,
  })  : _newReceiveMessage = newReceivedMessage,
        _initialized = initialized;

  final Map<String, Object?>? _newReceiveMessage;
  final bool? _initialized;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return (_newReceiveMessage != null)
        ? beliefs.copyWith(
            analysis: beliefs.analysis.copyWith(
              initialized: _initialized,
              receivedMessages: [
                ...beliefs.analysis.receivedMessages,
                _newReceiveMessage!
              ],
            ),
          )
        : beliefs;
  }

  @override
  toJson() => {
        'name_': 'AnalysisUpdate',
        'state_': {
          'newReceiveMessage': _newReceiveMessage,
        },
      };
}
