import 'package:analysis_server_utils/analysis_server_utils.dart';
import 'package:lsp_client/lsp_client.dart';

class AnalysisSystem {
  AnalysisSystem({AnalysisServer? server})
      : _server = server ??
            AnalysisServer(
              config: AnalysisServerConfig(
                clientId: 'enspyr.co',
                clientVersion: '0.0.1',
                logFile: 'analysis_server_utils.log',
                sdkPath: '/Users/nick/SDKs/flutter/bin/cache/dart-sdk',
              ),
            );

  final AnalysisServer _server;
  late final AnalysisClient _client = AnalysisClient(_server.streamChannel);

  Future<void> startServer(InitializeParams initializeParams) async {
    await _server.start();
    _server.initialize(paramsJson: initializeParams.toJson());
  }

  // LSP spec requires an 'initialized' notification be sent to the server
  // "after the client received the result of the initialize request but before
  // the client is sending any other request or notification to the server".
  // See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#initialized
  void declareServerInitialized() =>
      _client.call(method: 'initialized', params: {});

  void requestSemanticTokens(Uri fileUri) {
    _client.call(
      method: 'textDocument/semanticTokens/full',
      params: SemanticTokensParams(
        textDocument: TextDocumentIdentifier(uri: fileUri),
      ).toJson(),
    );
  }

  Stream<Map<String, Object?>> get onJsonFromServer => _client.onJsonFromServer;

  Future<void> dispose() => _server.dispose();
}
