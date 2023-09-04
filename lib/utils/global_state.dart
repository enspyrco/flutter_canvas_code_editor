import 'package:flutter/foundation.dart';

final heightNotifier = ValueNotifier<double>(0);
final codeUpdateNotifier = CodeUpdateNotifier();

class CodeUpdateNotifier with ChangeNotifier {
  void update() {
    notifyListeners();
  }
}
