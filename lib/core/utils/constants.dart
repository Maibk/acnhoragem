class Constants {
  static const String apiKey = "AIzaSyBGEIaWOwOk_fVYX8dlJ9YUFJl36uWxpfY";

  static const String map_static_url = "https://maps.googleapis.com/maps/api/staticmap?location=";

  static const String not_implment_msg = "Will be implement in next release";

  static const String userImagePlaceholder =
      "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png?20170328184010";

  static const roleId = 3; //Customer Role Id

  static const limitPerPage5 = 5; //Limit Per Page
  static const limitPerPage10 = 10; //Limit Per Page
  static const limitPerPage15 = 15; //Limit Per Page
  static const limitPerPage20 = 20; //Limit Per Page

  static const limitMaxHashtags = 10;
  static const limitMaxPostImages = 5;

  //Notification Types
  static const notificationPost = 10;
  static const notificationRestaurant = 10;
  static const notificationEvent = 10;
  static const notificationUser = 10;

  //Module Types
  static const modulePost = 'post';
  static const moduleUsers = 'user';
  static const moduleRestaurants = 'restaurant';
  static const moduleHashtags = 'hashtag';
  static const moduleEvents = 'event';

  //Category Types
  static const categoryPost = 'post';
  static const categoryMenu = 'menu';
  static const categoryReportPost = 'report_post';
  static const categoryReportUser = 'report_user';

  //Role Types
  static const roleTypeRestaurant = 'restaurant';
  static const roleTypeUser = 'user';

  //Reward Filters
  static const filterUpcoming = 'upcoming';
  static const filterPast = 'past';

  //Deeplink base urlf
  static const shareBaseUrl = 'spotFindrApp://share';

  //API ENDPOINTS
  // static const baseUrl = 'https://spotfinder-backend.tekstagearea.com/api/v1';
  static const baseUrl = 'https://anchorageislamabad.com/api/';
  static const preSignedBaseUrl = 'https://s3-presigned-svc.tekstagearea.com/api/v1/';

  //S3 presigned url
  static const preSignedUrl = '${preSignedBaseUrl}files';
  static const preSignedHeaderValue = "ehK2wPZR54qDHNJKNtw5";

  static const registerUrl = '${baseUrl}register';
  static const loginUrl = '${baseUrl}login';
  static const forgotPassUrl = '${baseUrl}forgot-password';
  static const resetPassUrl = '${baseUrl}reset-password';
  static const ad = '${baseUrl}downloadable-forms/ad';
  static const bcd = '${baseUrl}downloadable-forms/bcd';
  static const ro = '${baseUrl}downloadable-forms/ro';
  static const pec = '${baseUrl}downloadable-forms/pec';
  static const amc = '${baseUrl}downloadable-forms/amc';
  static const complaintUrl = '${baseUrl}complaint';
  static const complaintTypeUrl = '${baseUrl}complaint-type';
  static const viewComplainUrl = '${baseUrl}complaint/';
  static const getStreetByBlockUrl = '${baseUrl}street/';
  static const getPlotByStreetUrl = '${baseUrl}plot/';
  static const billsUrl = '${baseUrl}bills';
  static const ownerApplicationUrl = '${baseUrl}owner-application';
  static const getProfileUrl = '${baseUrl}profile';
  static const updateProfileUrl = '${baseUrl}update-profile';
  static const getProperties = '${baseUrl}properties';

  static const updatePassUrl = baseUrl + 'user/updatePassword';
  static const updateOldPassUrl = baseUrl + 'user/update-old-password';
  static const bannersUrl = baseUrl + 'banners';
  static const categoryUrl = baseUrl + 'category';
  static const productUrl = baseUrl + 'product';
  static const searchProductUrl = baseUrl + 'product/search';
  static const dealsUrl = baseUrl + 'deals';
  static const shopUrl = baseUrl + 'shop';
  static const orderTrackUrltest = baseUrl + 'order/track/1';
  static const orderTrackUrl = baseUrl + 'order/track/';
  static const orderHistoryUrl = baseUrl + 'order/history';
  static const ordercreateUrl = baseUrl + 'order/create';
  static const ducumentsUrl = baseUrl + 'documents';
  static const usersUrl = baseUrl + 'user';
  static const UpdateuserProfileUrl = baseUrl + 'user/updateProfile';
  static const topSellingProductUrl = baseUrl + 'topSelling';
  static const topSearchCategoryUrl = baseUrl + 'product/search/test';
  static const productUploadUrl = baseUrl + 'product/uploadProduct';
  static const logoutUrl = baseUrl + 'user/logout';
  static const deleteUrl = baseUrl + 'user/delete';
  static const forgotEmailUrl = baseUrl + 'userForgetEmail';
  static const resetUserPasswordUrl = baseUrl + 'resetUserPassword';
  static const addshopreviewUrl = baseUrl + 'add_shop_review';

  static const socialLoginUrl = baseUrl + '/social_login';
  static const updateUserUrl = baseUrl + '/users';

  static const forgotPasswordUrl = baseUrl + '/forget-password';
}
