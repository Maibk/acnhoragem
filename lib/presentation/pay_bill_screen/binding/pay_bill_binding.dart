import 'package:anchorageislamabad/presentation/pay_bill_screen/controller/Pay_bill_controller.dart';
import 'package:get/get.dart';

/// A binding class for the DiscoverScreen.
///
/// This class ensures that the DiscoverController is created when the
/// DiscoverScreen is first loaded.
class PayBillScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PayBillController());
  }
}
