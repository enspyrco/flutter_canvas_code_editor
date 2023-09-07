import 'package:abstractions/beliefs.dart';

class AnalysisBeliefs implements CoreBeliefs {
  AnalysisBeliefs({
    required this.receivedMessages,
  });

  final List<Map<String, Object?>> receivedMessages;

  static AnalysisBeliefs get initial => AnalysisBeliefs(
        receivedMessages: [],
      );

  @override
  AnalysisBeliefs copyWith({
    List<Map<String, Object?>>? receivedMessages,
  }) =>
      AnalysisBeliefs(
        receivedMessages: receivedMessages ?? this.receivedMessages,
      );

  @override
  toJson() => {
        'receivedMessages': receivedMessages,
      };
}
