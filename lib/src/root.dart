import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/app.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/models/user_model.dart';
import 'package:instagram_clone/src/screens/login_screen.dart';
import 'package:instagram_clone/src/screens/signup_screen.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, user) {
        if (user.hasData) {
          return FutureBuilder<UserModel?>(
              future: controller.loginUser(user.data!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const App();
                } else {
                  return Obx(() => controller.user.value.uid != null
                    ? const App()
                    : SignupScreen(uid: user.data!.uid)
                  );
                }
              }
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
