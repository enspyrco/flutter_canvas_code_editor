import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class AnalysisUpdated extends Conclusion<IDEBeliefs> {
  const AnalysisUpdated({
    Map<String, Object?>? newReceivedMessage,
    Map<String, Object?>? newSentMessage,
    bool? initialized,
  })  : _newReceiveMessage = newReceivedMessage,
        _newSentMessage = newSentMessage,
        _initialized = initialized;

  final Map<String, Object?>? _newReceiveMessage;
  final Map<String, Object?>? _newSentMessage;
  final bool? _initialized;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return (_newSentMessage != null ||
            _newReceiveMessage != null ||
            _initialized != null)
        ? beliefs.copyWith(
            analysis: beliefs.analysis.copyWith(
              initialized: _initialized,
              sentMessages: _newSentMessage == null
                  ? beliefs.analysis.sentMessages
                  : [...beliefs.analysis.sentMessages, _newSentMessage!],
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
          'newSentMessage': _newSentMessage,
          'newReceiveMessage': _newReceiveMessage,
        },
      };
}
