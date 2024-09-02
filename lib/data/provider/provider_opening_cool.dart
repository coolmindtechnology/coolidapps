// import 'package:cool_app/data/data_global.dart';
// import 'package:cool_app/data/repositories/repo_opening_cool.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../../generated/l10n.dart';
// import '../../presentation/utils/nav_utils.dart';
// import '../../presentation/utils/notification_utils.dart';
// import '../helpers/either.dart';
// import '../helpers/failure.dart';
// import '../response/res_opening_cool.dart';
//
// class ProviderOpeningCool extends ChangeNotifier {
//   ProviderOpeningCool(BuildContext context) {
//     getOpeningCool(context);
//   }
//
//   RepoOpeningCool repo = RepoOpeningCool();
//   bool isOpening = false;
//   DataOpening? dataOpening;
//   Future<void> getOpeningCool(BuildContext context) async {
//     isOpening = true;
//     notifyListeners();
//     Either<Failure, ResOpeningCool> response = await repo.getOpeningCool();
//     isOpening = false;
//     notifyListeners();
//
//     response.when(error: (e) {
//       NotificationUtils.showDialogError(context, () {
//         Nav.back();
//       },
//           widget: Text(
//             e.message,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16),
//           ),
//           textButton: S.of(context).back);
//     }, success: (res) async {
//       if (res.data != null) {
//         dataOpening = res.data;
//         dataGlobal.dataOpening = dataOpening;
//         if (kDebugMode) {
//           print("data opening ${dataOpening?.sound ?? ""}");
//         }
//         notifyListeners();
//       } else {
//         dataOpening = res.data;
//         notifyListeners();
//       }
//     });
//     notifyListeners();
//   }
// }
