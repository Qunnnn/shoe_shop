import 'package:get/get.dart';

class Dimens {
  static final dhp10 = Dimens.getHeight(height: 10);
  static final dhp15 = Dimens.getHeight(height: 15);
  static final dhp20 = Dimens.getHeight(height: 20);
  static final dhp25 = Dimens.getHeight(height: 25);

  static final dwp10 = Dimens.getWidth(width: 10);
  static final dwp15 = Dimens.getWidth(width: 15);
  static final dwp20 = Dimens.getWidth(width: 20);

  static getHeight({required height}) {
    final x = Get.height / height;
    return Get.height / x;
  }

  static getWidth({required width}) {
    final x = Get.width / width;
    return Get.width / x;
  }
}
