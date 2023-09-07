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
  late final AnalysisServerClient _client =
      AnalysisServerClient(_server.streamChannel);

  Future<void> startServer() async {
    await _server.start();
    _server.initialize();
  }

  Stream<Map<String, Object?>> getReceiveStream() =>
      _client.transformedServerOutput();

  Future<void> dispose() => _server.dispose();
}
