import 'package:abstractions/beliefs.dart';

class AnalysisBeliefs implements CoreBeliefs {
  AnalysisBeliefs({
    required this.receivedMessages,
    required this.initialized,
  });

  final List<Map<String, Object?>> receivedMessages;
  final bool initialized;

  static AnalysisBeliefs get initial => AnalysisBeliefs(
        receivedMessages: [],
        initialized: false,
      );

  @override
  AnalysisBeliefs copyWith({
    List<Map<String, Object?>>? receivedMessages,
    bool? initialized,
  }) =>
      AnalysisBeliefs(
        receivedMessages: receivedMessages ?? this.receivedMessages,
        initialized: initialized ?? this.initialized,
      );

  @override
  toJson() => {
        'receivedMessages': receivedMessages,
        'initialized': initialized,
      };
}
