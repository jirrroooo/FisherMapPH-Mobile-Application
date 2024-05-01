class Credentials {
  final String API = "10.0.2.2:3001";
  final String LOGIN = "auth/login";
  final String REGISTER = "/auth/signup";
  final String USER_ID = "/auth/profile";
  final String LOG = "/logs";
  final String USER = "/users";
  static String firstName = "";

  setFirstName(String firstName) {
    Credentials.firstName = firstName;
  }
}
