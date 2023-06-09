import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';
import '../utils/app_enums.dart';
import '../utils/app_extensions.dart';

Future<bool?> buildToast({
  required ToastType toastType,
  required String msg,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: toastType.getColor(),
    textColor: AppColors.white,
  );
}
