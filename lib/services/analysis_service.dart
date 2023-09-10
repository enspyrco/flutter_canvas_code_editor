import 'package:analysis_server_utils/analysis_server_utils.dart';
import 'package:lsp_client/lsp_client.dart';

class AnalysisService {
  AnalysisService({AnalysisServer? server})
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

  Future<void> startServer() async {
    await _server.start();
    _server.initialize();
  }

  // LSP spec requires an 'initialized' notification be sent to the server
  // "after the client received the result of the initialize request but before
  // the client is sending any other request or notification to the server".
  // See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#initialized
  void declareServerInitialized() =>
      _client.call(method: 'initialized', params: {});

  Stream<Map<String, Object?>> get onJsonFromServer => _client.onJsonFromServer;

  Future<void> dispose() => _server.dispose();
}
