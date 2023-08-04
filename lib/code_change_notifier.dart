import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class CodeChangeNotifier extends ChangeNotifier {
  CodeChangeNotifier()
      : tokens = [],
        _currentToken = const TextSpan(text: '') {
    tokens.add(_currentToken);
  }

  /// The tokens that make up the code, as TextSpans.
  final List<TextSpan> tokens;

  TextSpan _currentToken;

  void add(String character) {
    if (character == ' ') {
      tokens.add(const TextSpan(text: ' '));
      _currentToken = const TextSpan(text: '');
      tokens.add(_currentToken);
      notifyListeners();
      return;
    }
    _currentToken = TextSpan(text: '${_currentToken.text}$character');
    tokens.removeLast();
    tokens.add(_currentToken);
    notifyListeners();
  }

  void remove() {
    if (_currentToken.text == '') {
      if (tokens.length > 1) tokens.removeLast();
      if (tokens.length > 1) tokens.removeLast();
      _currentToken = tokens.last;
      notifyListeners();
      return;
    }
    final newText = (_currentToken.text == null || _currentToken.text!.isEmpty)
        ? ''
        : _currentToken.text!.substring(0, _currentToken.text!.length - 1);
    _currentToken = TextSpan(text: newText);
    tokens.removeLast();
    tokens.add(_currentToken);
    notifyListeners();
  }
}
