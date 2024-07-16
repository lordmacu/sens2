import 'package:get/get.dart';

class PageviewController extends GetxController {
  var currentPageIndex = 0.obs;

  void changePageIndex(int index) {
    currentPageIndex.value = index;
  }

}