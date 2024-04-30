import 'package:anchorageislamabad/presentation/reset_screen.dart/controller/reset_controller.dart';
import 'package:get/get.dart';

/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class ResetBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetController());
  }
}
