class Constants {
  static const String apiKey = "AIzaSyBGEIaWOwOk_fVYX8dlJ9YUFJl36uWxpfY";

  static const String map_static_url = "https://maps.googleapis.com/maps/api/staticmap?location=";

  static const String not_implment_msg = "Will be implement in next release";
  static String device_token = "";
  static String device_type = "";

  static const String userImagePlaceholder = "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png?20170328184010";

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
  static const baseUrl = 'https://anchorageislamabad.com/api/';

  //S3 presigned url
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
  static const messagesOnComplainUrl = '${baseUrl}complaint/';
  static const getStreetByBlockUrl = '${baseUrl}street/';
  static const getPlotByStreetUrl = '${baseUrl}plot/';
  static const billsUrl = '${baseUrl}bills';
  static const ownerApplicationUrl = '${baseUrl}owner-application';
  static const getProfileUrl = '${baseUrl}profile';
  static const updateProfileUrl = '${baseUrl}update-profile';
  static const getProperties = '${baseUrl}properties';
  static const logout = '${baseUrl}logout';

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
  static const entryCardUrl = baseUrl + 'entry-card/';
  static const entryCardUpdateUrl = baseUrl + 'entry-card/update';
  static const servantFormUrl = baseUrl + 'servant-card/';
  static const vehicleFormUrl = baseUrl + 'vehicle/';

  static const forgotPasswordUrl = baseUrl + '/forget-password';

  static const String agreementText = """
I, S/O or D/O CNIC NO. hereby solemnly affirm that the above-mentioned information given by me about business at Naval Anchorage Islamabad is true to the best of my knowledge, if found incorrect at any stage I will be liable to be persecuted under special conditions for residing in Anchorage Society.

I will ensure that utility charges / bills will be paid by me timely. In case of non-compliance owner will be responsible for the same.

I will exercise my utmost efforts to conserve water and will avoid littering in the society.

I will observe good social and moral norms during my stay in Anchorage Society.

I will strictly prohibit employment of child labour at my business.

I will neither provide shelter to anyone who is involved in illegal and criminal activities or required by the law enforcement agencies nor will conduct any activity in violation of the law of Pakistan.

I will not hold any function outside my rented space which can be a source of disturbance for other residents.

I will not hire any private security guard who carries weapon with him in Anchorage society.

I will follow the queue for rectification of minor defects in my house by the maintenance staff.

If I am found involved in any immoral / illegal activity, the Administration has the right to eject me from the society.

I will abide by Naval Anchorage Society terms and conditions and adhere to rules / regulations issued from time to time by Naval Headquarters including NOC.

I shall ensure that conduct of my visitors and my employees always remains above board and in accordance with the established civil norms.

I will register my employee’s and their vehicles at Naval Anchorage Security Office as per the SOPs.

I will give access to Naval Anchorage Administration/ Security to my CCTV if and when required at the earliest convenience without formal writing request.

I fully understand that Administrative Staff of Naval Anchorage is functioning to look after the collective interest of the residents of the Anchorage Society and to whom I shall afford complete co-operation in the execution of their duties and abide by the instructions issued from time to time especially in the terms of security and administration.

Dispute if any shall be mutually resolved in a considerate, thoughtful and understanding manner seeking arbitration of Dy Administrator where felt necessary, and I will not take matters concerning Naval Anchorage dispute to the court but the decision of Dy Administrator as arbitrators will be final. If at all any party opt to go to the court then he will pay all the expenditures incurred during court proceedings till the finalization of the case to the Anchorage Administration. In case the owner wants to serve vacation notice to the tenant prior completion of the contract period the notice has to be processed through Administration Office for approval / consent.

I will handover quiet and peace full possession of subject premises on completion of agreed tenure and before vacating I will submit owner’s NOC in Administration Office.

I will neither accommodate nor allow visit of any foreigner specially INDIAN nationals in the subject premises without prior approval of Anchorage Administration.

I fully understand that even if the Tenancy Agreement is valid but NOC period has expired, I can no longer reside in Naval Anchorage society premises and vice versa.

If the NOC has been cancelled by the issuing authority. I will vacate the rented premises within 30 days of the cancellation of NOC.

In case of any violation/ unbecoming of a law-abiding citizen, the Naval Anchorage Directorate reserves the right to cancel the NOC of the said business.

It is the responsibility of Plaza Owner / nominated Estate Agent to provide rent agreement and filled NOC FORM to the Administration Office before renting out the property/ moving in of tenant. The tenant police registration (Police Service Center F-6 Islamabad) is to be submitted within 15 days of shifting, thereafter fine will be charged on daily basis for 1 x month, failing to which the NOC will be cancelled.

Addition/ alteration in building without obtained revised building plan approval is not allowed. Any construction started/ carried out without prior approval will be removed/ dismantled at risk & cost of the owner(s)/ allotee/ occpants(s) and/ or penalty will be imposed as per policy in vague.

Usage of residential building/ plots for commercial/ industrial use is illegal. Morover, residential buildings usage as regular wirship places like Masjids, Jamat Khanas, Imam Margahs etc. is illegal and not allowed.

Construction of permanent structure of any kind outside the building line is not permitted. Moreover, No temporary structure of any kind outside/ setback of building is allowed without prior approval of BCD.

Service area can be utilized only for plantation/ grass purpose. No wall/ grill/ fence/ hard planter/ fountain/ cages can be constructed in service area. This area should be available for maintenance of services as and when needed by the society.

The ownership rights of green area adjacent to any plot shall remain with the society. Same should not be enclosed by walls, grill and/ or fence in such a manner to restrict public approach/ access.

Allotee(s)/ occupants (s) are required not to throw any waste material in dustbins other than kitchen waste which should be wrapped in plastic bags. No any waste material/ garbage is to be dumped on service area or adjacent plots.

No building, structure, or any part thereof should be occupied or used without obtaining completion certificate (permission to occupy).
""";
}
