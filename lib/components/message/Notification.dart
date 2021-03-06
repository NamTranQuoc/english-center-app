import 'package:english_center/util/LocalStorage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoader() async {
  await EasyLoading.show(
    status: 'loading...',
    maskType: EasyLoadingMaskType.black,
  );
}

final Map<String, String> en = {
  "signup_success": "Successful registration",
  "register_success": "Successful registration",
  "can_not_update": "Unable to update",
  "cannot_when_status_not_is_create":
      "Can only update while in initialization state",
  "can_only_generate_with_status_is_create":
      "Can only update the calendar while in initialization state",
  "cannot_when_status_not_is_register": "Outside of registration period",
  "phone_number_used": "Phone number already in use",
  "room_not_empty": "Classroom is not empty",
  "teacher_not_available": "Teacher not available",
  "schedule_not_exist": "Schedule does not exist",
  "schedule_exist": "Schedule already exists",
  "param_not_null": "Data cannot be empty",
  "member_exist": "The user already exists",
  "member_not_exist": "User does not exist",
  "category_course_not_exist": "Course does not exist",
  "course_not_exist": "Course does not exist",
  "password_incorrect": "Password is incorrect",
  "confirm_password_incorrect": "Confirm password is incorrect",
  "member_type_deny": "User does not have access",
  "shift_not_exist": "The shift does not exist",
  "room_not_exist": "Classroom does not exist",
  "document_not_exist": "Document does not exist",
  "document_extension_not_match": "No permission to download document",
  "start_date_not_allow": "Start time not allowed",
  "classroom_not_exist": "Class does not exist",
  "exam_schedule_not_exist": "Test schedule does not exist",
  "room_not_available": "The ward is not available",
  "class_full": "Class is full",
  "input_score_not_enough": "Insufficient input score",
  "unsubscribe_timeout": "Outside of unsubscribe time",
  "register_not_in_time_register": "Not during registration",
  "register_already": "Registered",
  "exam_schedule_conflict": "Double test schedule",
  "class_registered": "Registered",
  "code_incorrect": "Incorrect code"
};

final Map<String, String> vi = {
  "signup_success": "????ng k?? th??nh c??ng",
  "register_success": "Ghi danh th??nh c??ng",
  "can_not_update": "Kh??ng th??? c???p nh???t",
  "cannot_when_status_not_is_create":
      "Ch??? c?? th??? c???p nh???t khi ??? tr???ng th??i kh???i t???o",
  "can_only_generate_with_status_is_create":
      "Ch??? c?? th??? c???p t???o l???ch khi ??? tr???ng th??i kh???i t???o",
  "cannot_when_status_not_is_register": "Ngo??i th???i gian ????ng k??",
  "phone_number_used": "S??? ??i???n tho???i ???? ???????c s??? d???ng",
  "room_not_empty": "Ph??ng h???c kh??ng tr???ng",
  "teacher_not_available": "Gi??o vi??n kh??ng s???n s??ng",
  "schedule_not_exist": "L???ch h???c kh??ng t???n t???i",
  "schedule_exist": "L???ch h???c ???? t???n t???i",
  "param_not_null": "D??? li???u kh??ng ???????c ????? tr???ng",
  "member_exist": "Ng?????i d??ng ???? t???n t???i",
  "member_not_exist": "Ng?????i d??ng kh??ng t???n t???i",
  "category_course_not_exist": "Ch????ng tr??nh h???c kh??ng t???n t???i",
  "course_not_exist": "Kh??a h???c kh??ng t???n t???i",
  "password_incorrect": "M???t kh???u kh??ng ch??nh x??c",
  "confirm_password_incorrect": "X??c nh???n m???t kh???u kh??ng ch??nh x??c",
  "member_type_deny": "Ng?????i d??ng kh??ng c?? quy???n truy c???p",
  "shift_not_exist": "Ca h???c kh??ng t???n t???i",
  "room_not_exist": "Ph??ng h???c kh??ng t???n t???i",
  "document_not_exist": "T??i li???u kh??ng t???n t???i",
  "document_extension_not_match": "Kh??ng c?? quy???n t???i t??i li???u",
  "start_date_not_allow": "Th???i gian b???t ?????u kh??ng ???????c ph??p",
  "classroom_not_exist": "L???p h???c kh??ng t???n t???i",
  "exam_schedule_not_exist": "L???ch ki???m tra kh??ng t???n t???i",
  "room_not_available": "Ph?????ng h???c kh??ng s???n s??ng",
  "class_full": "L???p h???c ???? ?????y",
  "input_score_not_enough": "??i???m ?????u v??o kh??ng ?????",
  "unsubscribe_timeout": "Ngo??i th???i gian h???y ????ng k??",
  "register_not_in_time_register": "Kh??ng trong th???i gian ????ng k??",
  "register_already": "???? ????ng k??",
  "exam_schedule_conflict": "Tr??ng l???ch ki???m tra",
  "class_registered": "???? ????ng k??",
  "code_incorrect": "Code kh??ng ch??nh x??c"
};

Future<String> getMessage(String content) async {
  String result = "";
  String language = await LocalStorage().getLanguage();
  if (language == 'en') {
    result = en[content] ?? "";
  } else {
    result = vi[content] ?? "";
  }
  if (result != "") {
    return result;
  }
  return content;
}

void showSuccess(String content) async {
  String message = await getMessage(content);
  await EasyLoading.showSuccess(message);
}

void showError(String content) async {
  String message = await getMessage(content);
  await EasyLoading.showError(message);
}

void showInfo(String content) async {
  String message = await getMessage(content);
  await EasyLoading.showInfo(message);
}

void showToast(String content) async {
  String message = await getMessage(content);
  await EasyLoading.showToast(message);
}

void dismiss() async {
  await EasyLoading.dismiss();
}
