class ApiUrls {
  static const baseURL = "https://bus-tracking-ohy5.onrender.com/";

  static const apiV = "api/v1/";

  static const signin = "$baseURL${apiV}auth/signin";
  static const signup = "$baseURL${apiV}auth/signup";

  static const fetchBus = "$baseURL${apiV}bus";

  static const fetchTicket = "$baseURL${apiV}ticket";
}
