import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class AnalysisUpdate extends Conclusion<IDEBeliefs> {
  const AnalysisUpdate({
    Map<String, Object?>? newReceivedMessage,
  }) : _newReceiveMessage = newReceivedMessage;

  final Map<String, Object?>? _newReceiveMessage;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return (_newReceiveMessage != null)
        ? beliefs.copyWith(
            analysis: beliefs.analysis.copyWith(
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
