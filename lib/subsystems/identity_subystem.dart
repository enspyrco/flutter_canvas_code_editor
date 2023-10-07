import 'package:abstractions/subsystems.dart';

class IdentitySubystem implements Subsystem {
  const IdentitySubystem();

  String getCurrentUserId() => 'bob';
}
