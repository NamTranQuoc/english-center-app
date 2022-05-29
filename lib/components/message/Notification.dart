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
  "signup_success": "Đăng ký thành công",
  "register_success": "Ghi danh thành công",
  "can_not_update": "Không thể cập nhật",
  "cannot_when_status_not_is_create":
      "Chỉ có thể cập nhật khi ở trạng thái khởi tạo",
  "can_only_generate_with_status_is_create":
      "Chỉ có thể cập tạo lịch khi ở trạng thái khởi tạo",
  "cannot_when_status_not_is_register": "Ngoài thời gian đăng ký",
  "phone_number_used": "Số điện thoại đã được sử dụng",
  "room_not_empty": "Phòng học không trống",
  "teacher_not_available": "Giáo viên không sẳn sàng",
  "schedule_not_exist": "Lịch học không tồn tại",
  "schedule_exist": "Lịch học đã tồn tại",
  "param_not_null": "Dữ liệu không được để trống",
  "member_exist": "Người dùng đã tồn tại",
  "member_not_exist": "Người dùng không tồn tại",
  "category_course_not_exist": "Chương trình học không tồn tại",
  "course_not_exist": "Khóa học không tồn tại",
  "password_incorrect": "Mật khẩu không chính xác",
  "confirm_password_incorrect": "Xác nhận mật khẩu không chính xác",
  "member_type_deny": "Người dùng không có quyền truy cập",
  "shift_not_exist": "Ca học không tồn tại",
  "room_not_exist": "Phòng học không tồn tại",
  "document_not_exist": "Tài liệu không tồn tại",
  "document_extension_not_match": "Không có quyền tải tài liệu",
  "start_date_not_allow": "Thời gian bắt đầu không được phép",
  "classroom_not_exist": "Lớp học không tồn tại",
  "exam_schedule_not_exist": "Lịch kiểm tra không tồn tại",
  "room_not_available": "Phường học không sẳn sàng",
  "class_full": "Lớp học đã đầy",
  "input_score_not_enough": "Điểm đầu vào không đủ",
  "unsubscribe_timeout": "Ngoài thời gian hủy đăng ký",
  "register_not_in_time_register": "Không trong thời gian đăng ký",
  "register_already": "Đã đăng ký",
  "exam_schedule_conflict": "Trùng lịch kiểm tra",
  "class_registered": "Đã đăng ký",
  "code_incorrect": "Code không chính xác"
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
