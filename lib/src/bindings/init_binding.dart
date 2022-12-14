import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:instagram_clone/src/controller/home_controller.dart';
import 'package:instagram_clone/src/controller/my_controller.dart';

class InitBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding(){
    Get.put(MyController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}