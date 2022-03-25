
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoader() async {
  await EasyLoading.show(
    status: 'loading...',
    maskType: EasyLoadingMaskType.black,
  );
}

void showSuccess(String content) async {
  await EasyLoading.showSuccess(content);
}

void showError(String content) async {
  await EasyLoading.showError(content);
}

void showInfo(String content) async {
  await EasyLoading.showInfo(content);
}

void showToast(String content) async {
  await EasyLoading.showToast(content);
}

void dismiss() async {
  await EasyLoading.dismiss();
}
