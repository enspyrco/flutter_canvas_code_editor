import 'package:abstractions/beliefs.dart';

class AnalysisBeliefs implements CoreBeliefs {
  AnalysisBeliefs({
    required this.receivedMessages,
    required this.sentMessages,
    required this.initialized,
  });

  final List<Map<String, Object?>> receivedMessages;
  final List<Map<String, Object?>> sentMessages;
  final bool initialized;

  static AnalysisBeliefs get initial => AnalysisBeliefs(
        receivedMessages: [],
        sentMessages: [],
        initialized: false,
      );

  @override
  AnalysisBeliefs copyWith({
    List<Map<String, Object?>>? receivedMessages,
    List<Map<String, Object?>>? sentMessages,
    bool? initialized,
  }) =>
      AnalysisBeliefs(
        receivedMessages: receivedMessages ?? this.receivedMessages,
        sentMessages: sentMessages ?? this.sentMessages,
        initialized: initialized ?? this.initialized,
      );

  @override
  toJson() => {
        'receivedMessages': receivedMessages,
        'sentMessages': sentMessages,
        'initialized': initialized,
      };
}
