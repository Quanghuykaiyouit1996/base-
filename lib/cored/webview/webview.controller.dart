
import 'package:get/get.dart';

class WebviewController extends GetxController {
  late String url;
  @override
  void onInit() {
    url = Get.arguments;
    super.onInit();
  }
}
