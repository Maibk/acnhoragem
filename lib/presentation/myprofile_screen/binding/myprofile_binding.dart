import '../controller/myprofile_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DiscoverScreen.
///
/// This class ensures that the DiscoverController is created when the
/// DiscoverScreen is first loaded.
class MyprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyprofileController());
  }
}
