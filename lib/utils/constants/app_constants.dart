class AppConstants {
  static const String APP_NAME = "TBest Food";
  static const String APP_VERSION = '1.0.0';

  // database for product and cart endpoints
  static const String BASE_URL = "http://10.0.2.2:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads/";

  //user amd auth endpoints
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String USER_ADDRESS = 'user_address';
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';

  static const String TOKEN = "";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String PHONE = "";
  static const String PASSWORD = "";
}
