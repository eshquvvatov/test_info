class ApiConstants {

  ApiConstants._();
  // Base URL
  static const String baseUrl = "https://api.staff.mobilux.uz/mobile";

  // Auth Endpoints
  static const String oldLogin = "/user/v1/ios-login/";
  static const String resetWithOtp = "/user/v1/reset-with-otp/";
  static const String checkResetOtp = "/user/v1/check-reset-otp/";
  static const String resetPassword = "/user/v1/reset-password/";
  static const String faceScan = "/user/v1/facescan/";

  // Home/Attendance Endpoints
  static const String getMonthDates = "/employment/v1/days/";
  static const String attendanceDetail = "/attendance/v1/detail/"; // + id
  static const String checkIn = "/attendance/v1/check-in/";
  static const String checkOut = "/attendance/v1/check-out/";
  static const String checkState = "/attendance/v1/check-state/";
  static const String attendanceInfo = "/attendance/v1/info/";

  // Support Endpoint
  static const String supportInfo = "/support/v1/";


}