import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class AnalysisUpdated extends Conclusion<IDEBeliefs> {
  const AnalysisUpdated({
    Map<String, Object?>? newReceivedMessage,
    bool? initialized,
  })  : _newReceiveMessage = newReceivedMessage,
        _initialized = initialized;

  final Map<String, Object?>? _newReceiveMessage;
  final bool? _initialized;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return (_newReceiveMessage != null || _initialized != null)
        ? beliefs.copyWith(
            analysis: beliefs.analysis.copyWith(
              initialized: _initialized,
              receivedMessages: _newReceiveMessage == null
                  ? beliefs.analysis.receivedMessages
                  : [...beliefs.analysis.receivedMessages, _newReceiveMessage!],
            ),
          )
        : beliefs;
  }

  @override
  toJson() => {
        'name_': 'AnalysisUpdated',
        'state_': {
          'initialized': _initialized,
          'newReceiveMessage': _newReceiveMessage,
        },
      };
}
