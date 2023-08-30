import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:framing_in_perception/framing_in_perception.dart';
import 'package:abstractions/beliefs.dart';
import 'package:abstractions/error_correction.dart';
import 'package:abstractions/framing.dart';

import '../../workspace/beliefs/workspace_beliefs.dart';

class IDEBeliefs
    implements CoreBeliefs, FramingConcept, ErrorCorrectionConcept {
  IDEBeliefs({
    required this.workspace,
    required this.error,
    required this.framing,
  });

  final WorkspaceBeliefs workspace;

  @override
  final DefaultErrorCorrectionBeliefs error;
  @override
  final DefaultFramingBeliefs framing;

  static IDEBeliefs get initial => IDEBeliefs(
        workspace: WorkspaceBeliefs.initial,
        error: DefaultErrorCorrectionBeliefs.initial,
        framing: DefaultFramingBeliefs.initial,
      );

  @override
  IDEBeliefs copyWith({
    WorkspaceBeliefs? workspace,
    DefaultFramingBeliefs? framing,
    DefaultErrorCorrectionBeliefs? error,
  }) =>
      IDEBeliefs(
        workspace: workspace ?? this.workspace,
        framing: framing ?? this.framing,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'workspace': workspace.toJson(),
        'navigation': framing.toJson(),
        'error': error.toJson(),
      };
}
