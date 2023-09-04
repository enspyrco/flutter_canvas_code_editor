import 'package:abstractions/beliefs.dart';

class AnalysisBeliefs implements CoreBeliefs {
  AnalysisBeliefs({
    required this.receivedStrings,
  });

  final List<String> receivedStrings;

  static AnalysisBeliefs get initial => AnalysisBeliefs(
        receivedStrings: [],
      );

  @override
  AnalysisBeliefs copyWith({
    List<String>? receivedStrings,
  }) =>
      AnalysisBeliefs(
        receivedStrings: receivedStrings ?? this.receivedStrings,
      );

  @override
  toJson() => {
        'receivedStrings': receivedStrings,
      };
}
