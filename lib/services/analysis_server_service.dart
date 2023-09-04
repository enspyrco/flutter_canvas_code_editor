import 'dart:io';

import 'package:analysis_server_utils/analysis_server_utils.dart';
import 'package:intl/intl.dart';
import 'package:lsp_models/lsp_models.dart';
import 'package:path/path.dart';

class AnalysisServerService {
  AnalysisServerService({AnalysisServer? server})
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

  Future<void> start() => _server.start();

  void initialize() {
    final params = InitializeParams(
      processId: pid,
      rootUri: Directory.current.uri,
      capabilities: ClientCapabilities(),
      initializationOptions: {},
      trace: const TraceValues.fromJson('verbose'),
      workspaceFolders: [
        WorkspaceFolder(
          name: basename(Directory.current.path),
          uri: Directory.current.uri,
        )
      ],
      clientInfo:
          InitializeParamsClientInfo(name: 'enspyr.co', version: '0.0.1'),
      locale: Intl.getCurrentLocale(),
    );

    _server.call(method: 'initialize', params: params.toJson());
  }

  Stream<String> getReceiveStream() => _server.onReceive;

  Future<void> dispose() => _server.dispose();
}
