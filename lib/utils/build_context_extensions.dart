// Currently uses the locator meaning there is no need to use an extension
// on BuildContext, however doing so makes it a lot easier if we decide to
// change later (which is quite possible as using the locator seems to have some
// problems, eg. breaks hot reload)

import 'package:abstractions/beliefs.dart';
import 'package:flutter/widgets.dart';
import 'package:locator_for_perception/locator_for_perception.dart';

import '../sections/i_d_e/beliefs/i_d_e_beliefs.dart';

extension BuildContextExtensions on BuildContext {
  void conclude(Conclusion<IDEBeliefs> conclusion) {
    return locate<BeliefSystem<IDEBeliefs>>().conclude(conclusion);
  }

  Future<void> consider(Consideration<IDEBeliefs> consideration) {
    return locate<BeliefSystem<IDEBeliefs>>().consider(consideration);
  }
}
