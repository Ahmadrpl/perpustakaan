import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:petugas/app/data/constan/endpoint.dart';
import 'package:petugas/app/data/provider/api_provider.dart';


class AddBookController extends GetxController {
  final GlobalKey<FormState> formKey= GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  //TODO: Implement AddBookController


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  final loadingBook = false.obs;
  addBook() async {
    loadingBook(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.book,
            data: {
              {
                "judul": judulController.text.toString(),
                "penulis": penulisController.text.toString(),
                "penerbit": penerbitController.text.toString(),
                "tahun_terbit": int.parse(tahunController.text.toString())
              }
            });
        if (response.statusCode == 200) {
          Get.back();
        } else {
          Get.snackbar("sorry", "Login Gagal", backgroundColor: Colors.orange);
        }
      }
      loadingBook(false);
    } on dio.DioException catch (e) {
      loadingBook(false);
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    } catch (e) {
      loadingBook(false);
      Get.snackbar("Error", e.toString() ?? "", backgroundColor: Colors.red);
      throw Exception('Error: $e');
    }
  }


}

