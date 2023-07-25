import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/auth_controller.dart';
import 'package:news_app/screen/auth/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: controller.email,
                decoration:
                    const InputDecoration(hintText: "Please enter email"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.password,
                decoration:
                    const InputDecoration(hintText: "Please enter password"),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<AuthController>(builder: (control) {
                return ElevatedButton(
                    onPressed: () {
                      controller.registerUser();
                    },
                    child: control.loading.isTrue
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Sign Up"));
              }),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    controller.clearData();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: const Text("Already have an account? Login"))
            ],
          ),
        ),
      ),
    );
  }
}
