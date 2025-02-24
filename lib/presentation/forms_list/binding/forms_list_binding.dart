import 'package:anchorageislamabad/presentation/forms_list/controller/forms_lists_controller.dart';
import 'package:get/get.dart';

class FormsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormsListsController());
  }
}
