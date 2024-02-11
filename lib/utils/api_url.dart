class AppUrl {
  static const String domainURL = "https://innovative-minds.mustansirg.in/codeshastra/";
  static const String dashboardURL = "${domainURL}dashboard";
  static const String apiURL = "${domainURL}api";
  static const String authURL = "${domainURL}api/auth/";
  static const String staticURL = "${domainURL}static";
  static const String socialURL = "$apiURL/social/";
  static const String mentorURL = "$apiURL/mentor/";

  static const String login = "${authURL}login/";
  static const String register = "${authURL}registration/";
  static const String refresh = "${authURL}token/refresh/";
  static const String resendEmailVerification = "$authURL/registration/resend-email/";
  static const String forgotPassword = "$authURL/password/reset/";

} 