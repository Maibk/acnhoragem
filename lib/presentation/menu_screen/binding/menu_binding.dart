import '../controller/menu_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DiscoverScreen.
///
/// This class ensures that the DiscoverController is created when the
/// DiscoverScreen is first loaded.
class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuController());
  }
}
