import 'package:abstractions/subsystem.dart';

class IdentitySubystem implements Subsystem {
  const IdentitySubystem();

  String getCurrentUserId() => 'bob';
}
