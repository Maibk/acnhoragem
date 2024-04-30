import 'package:anchorageislamabad/presentation/pay_bill_screen/pay_bill_screen.dart';
import 'package:anchorageislamabad/presentation/reset_screen.dart/reset_screen.dart';
import 'package:anchorageislamabad/presentation/reset_screen.dart/rest_binding.dart/reset_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../presentation/bills_screen/bills_screen.dart';
import '../presentation/bills_screen/binding/bills_binding.dart';
import '../presentation/complaints_screen/binding/complaints_binding.dart';
import '../presentation/complaints_screen/complaints_screen.dart';
import '../presentation/downloadforms_screen/binding/downloadforrms_binding.dart';
import '../presentation/downloadforms_screen/downloadforms_screen.dart';
import '../presentation/entryforms_screen/binding/entryforms_binding.dart';
import '../presentation/entryforms_screen/entryforms_screen.dart';
import '../presentation/forgot_screen/binding/forgot_binding.dart';
import '../presentation/forgot_screen/forgot_screen.dart';
import '../presentation/home_screen/binding/home_binding.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/menu_screen/binding/menu_binding.dart';
import '../presentation/menu_screen/menu_screen.dart';
import '../presentation/mycomplaints_screen/binding/mycomplaints_binding.dart';
import '../presentation/mycomplaints_screen/myComplaints_screen.dart';
import '../presentation/myforms_screen/binding/myforms_binding.dart';
import '../presentation/myforms_screen/myforms_screen.dart';
import '../presentation/myprofile_screen/binding/myprofile_binding.dart';
import '../presentation/myprofile_screen/myprofile_screen.dart';
import '../presentation/ownerform_screen/binding/ownerforms_binding.dart';
import '../presentation/ownerform_screen/ownerforms_screen.dart';
import '../presentation/pay_bill_screen/binding/pay_bill_binding.dart';
import '../presentation/properties_screen/binding/properties_binding.dart';
import '../presentation/properties_screen/properties_screen.dart';
import '../presentation/serventforms_screen/binding/serventforms_binding.dart';
import '../presentation/serventforms_screen/serventforms_screen.dart';
import '../presentation/signup_screen/binding/signup_binding.dart';
import '../presentation/signup_screen/signup_screen.dart';
import '../presentation/splash_screen/binding/splash_binding.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/tenantform_screen/binding/tenantforms_binding.dart';
import '../presentation/tenantform_screen/tenantforms_screen.dart';
import '../presentation/vechicleform_screen/binding/vechicle_binding.dart';
import '../presentation/vechicleform_screen/vechicleforms_screen.dart';

class AppRoutes {
  // static const String menuPage = '/menu_page';

  static const String menuContainerScreen = '/menu_container_screen';

  static const String splashScreen = '/splash_screen';
  static const String loginPage = '/login_screen';
  static const String signupPage = '/signup_screen';
  static const String forgotPassPage = '/forgot_screen';
  static const String resetPass = '/reset_screen';
  static const String homePage = '/home_screen';
  static const String billsPage = '/bills_screen';
  static const String complaintsPage = '/complaints_screen';
  static const String entryFormsPage = '/entryforms_screen';
  static const String menuPage = '/menu_screen';
  static const String myComplaintsPage = '/mycomplaints_screen';
  static const String myformsPage = '/myforms_screen';
  static const String payBillPage = '/pay_bill_screen';
  static const String myProfilePage = '/myprofile_screen';
  static const String propertiesPage = '/properties_screen';
  static const String vechicleFormsPage = '/vechicleforms_screen';
  static const String downLoadFormsPage = '/downloadforms_screen';
  static const String ownerFormsPage = '/ownerforms_screen';
  static const String tenantFormsPage = '/tenantforms_screen';
  static const String serventFormsPage = '/serventforms_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: loginPage,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: signupPage,
      page: () => SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
      name: forgotPassPage,
      page: () => ForgotPassScreen(),
      bindings: [
        ForgotPassBinding(),
      ],
    ),
    GetPage(
      name: resetPass,
      page: () => ResestPassScreen(),
      bindings: [
        ResetBindings(),
      ],
    ),
    GetPage(
      name: homePage,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: billsPage,
      page: () => billsScreen(),
      bindings: [
        BillsBinding(),
      ],
    ),
    GetPage(
      name: complaintsPage,
      page: () => CreateNewComplaintScreen(),
      bindings: [
        ComplaintsBinding(),
      ],
    ),
    GetPage(
      name: entryFormsPage,
      page: () => EntryFormsScreen(),
      bindings: [
        EntryFormsBinding(),
      ],
    ),
    GetPage(
      name: menuPage,
      page: () => MenuScreen(),
      bindings: [
        MenuBinding(),
      ],
    ),
    GetPage(
      name: myComplaintsPage,
      page: () => MyComplaintsScreen(),
      bindings: [
        MyComplaintsBinding(),
      ],
    ),
    GetPage(
      name: myformsPage,
      page: () => MyFormsScreen(),
      bindings: [
        MyFormsBinding(),
      ],
    ),
    GetPage(
      name: myProfilePage,
      page: () => MyprofileScreen(),
      bindings: [
        MyprofileBinding(),
      ],
    ),
    GetPage(
      name: propertiesPage,
      page: () => PropertiesScreen(),
      bindings: [
        PropertiesBinding(),
      ],
    ),
    GetPage(
      name: vechicleFormsPage,
      page: () => VechicleScreen(),
      bindings: [
        VechicleBinding(),
      ],
    ),
    GetPage(
      name: downLoadFormsPage,
      page: () => DownloadFormsScreen(),
      bindings: [
        DownloadFormsBinding(),
      ],
    ),
    GetPage(
      name: ownerFormsPage,
      page: () => OwnerFornsScreen(),
      bindings: [
        OwnerFornsScreenBinding(),
      ],
    ),
    GetPage(
      name: payBillPage,
      page: () => PayBillScreen(),
      bindings: [
        PayBillScreenBinding(),
      ],
    ),
    GetPage(
      name: tenantFormsPage,
      page: () => TenantFornsScreen(),
      bindings: [
        TenantFornsScreenBinding(),
      ],
    ),
    GetPage(
      name: serventFormsPage,
      page: () => ServentFormsScreen(),
      bindings: [
        ServentFormsBinding(),
      ],
    ),
  ];
}
