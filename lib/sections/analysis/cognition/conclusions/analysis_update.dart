import 'package:abstractions/beliefs.dart';

import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

class AnalysisUpdate extends Conclusion<IDEBeliefs> {
  const AnalysisUpdate({
    String? newReceivedMessage,
  }) : _newReceiveMessage = newReceivedMessage;

  final String? _newReceiveMessage;

  @override
  IDEBeliefs conclude(IDEBeliefs beliefs) {
    return (_newReceiveMessage != null)
        ? beliefs.copyWith(
            analysis: beliefs.analysis.copyWith(
              receivedStrings: [
                ...beliefs.analysis.receivedStrings,
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
