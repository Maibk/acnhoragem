import '../controller/ownerforms_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DiscoverScreen.
///
/// This class ensures that the DiscoverController is created when the
/// DiscoverScreen is first loaded.
class OwnerFornsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OwnerFornsScreenController());
  }
}
