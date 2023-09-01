import 'package:flutter/foundation.dart';

import 'code_change_notifier.dart';

final codeChangeNotifier = CodeChangeNotifier();
final heightNotifier = ValueNotifier<double>(0);
final codeUpdateNotifier = CodeUpdateNotifier();

class CodeUpdateNotifier with ChangeNotifier {
  void update() {
    notifyListeners();
  }
}
