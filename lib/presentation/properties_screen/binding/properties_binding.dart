import '../controller/properties_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DiscoverScreen.
///
/// This class ensures that the DiscoverController is created when the
/// DiscoverScreen is first loaded.
class PropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PropertiesController());
  }
}
