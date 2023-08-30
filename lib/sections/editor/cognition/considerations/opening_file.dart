// import 'package:abstractions/beliefs.dart';
// import 'package:locator_for_perception/locator_for_perception.dart';

// import '../../../../services/file_system_service.dart';
// import '../../../i_d_e/beliefs/i_d_e_beliefs.dart';

// class OpeningFile extends Consideration<IDEBeliefs> {
//   const OpeningFile({required String filePath}) : _filePath = filePath;

//   final String _filePath;

//   @override
//   Future<void> consider(BeliefSystem<IDEBeliefs> beliefSystem) async {
//     var service = locate<FileSystemService>();

//     service.openFile
//   }

//   @override
//   toJson() => {
//         'name_': 'OpeningFile',
//         'state_': {'filePath': _filePath},
//       };
// }
