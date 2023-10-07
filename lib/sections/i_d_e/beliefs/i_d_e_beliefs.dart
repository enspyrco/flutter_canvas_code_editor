import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:framing_in_perception/framing_in_perception.dart';
import 'package:abstractions/beliefs.dart';
import 'package:abstractions/error_correction.dart';
import 'package:abstractions/framing.dart';

import '../../analysis/beliefs/analysis_beliefs.dart';
import '../../editor/beliefs/editor_beliefs.dart';
import '../../workspace/beliefs/workspace_beliefs.dart';

class IDEBeliefs
    implements CoreBeliefs, FramingConcept, ErrorCorrectionConcept {
  IDEBeliefs({
    required this.analysis,
    required this.workspace,
    required this.editor,
    required this.error,
    required this.framing,
  });

  final AnalysisBeliefs analysis;
  final WorkspaceBeliefs workspace;
  final EditorBeliefs editor;

  @override
  final DefaultErrorCorrectionBeliefs error;
  @override
  final DefaultFramingBeliefs framing;

  static IDEBeliefs get initial => IDEBeliefs(
        analysis: AnalysisBeliefs.initial,
        workspace: WorkspaceBeliefs.initial,
        editor: EditorBeliefs.initial,
        error: DefaultErrorCorrectionBeliefs.initial,
        framing: DefaultFramingBeliefs.initial,
      );

  @override
  IDEBeliefs copyWith({
    AnalysisBeliefs? analysis,
    WorkspaceBeliefs? workspace,
    EditorBeliefs? editor,
    DefaultFramingBeliefs? framing,
    DefaultErrorCorrectionBeliefs? error,
  }) =>
      IDEBeliefs(
        analysis: analysis ?? this.analysis,
        workspace: workspace ?? this.workspace,
        editor: editor ?? this.editor,
        framing: framing ?? this.framing,
        error: error ?? this.error,
      );

  @override
  toJson() => {
        'analysis': analysis.toJson(),
        'workspace': workspace.toJson(),
        'editor': editor.toJson(),
        'framing': framing.toJson(),
        'error': error.toJson(),
      };
}
