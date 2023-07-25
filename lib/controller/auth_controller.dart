import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screen/home_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var loading = false.obs;
  var errorTxt = "".obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  onClose() {
    super.onClose();
    email.dispose();
    password.dispose();
    loading(false);
    errorTxt.value = "";
  }

  registerUser() {
    if (checkValidity()) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Please enter all field")));
      return;
    }
    loading(true);
    update();
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      clearData();
      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
    }, onError: (e) {
      loading(false);
      errorTxt.value = e.toString();
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      update();
    });
  }

  loginUser() {
    loading(true);
    update();
    firebaseAuth
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      clearData();
      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
    }, onError: (e) {
      loading(false);
      errorTxt.value = e.toString();
      update();
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  checkValidity() {
    if (email.text.isEmpty && password.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  clearData() {
    email.text = "";
    password.text = "";
    loading(false);
    errorTxt.value = "";
  }
}
