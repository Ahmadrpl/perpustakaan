import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constan/endpoint.dart';
import '../../../data/model/responsepinjam.dart';
import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController with StateMixin<List<DataPinjam>>{
  final GlobalKey<FormState> formkey= GlobalKey<FormState>();
  final TextEditingController useridController = TextEditingController();
  final TextEditingController bookidController = TextEditingController();
  final TextEditingController tglpinjamController = TextEditingController();
  final TextEditingController tglkembaliController = TextEditingController();
  //TODO: Implement PeminjamanController

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
  final loadingPinjam = false.obs;
  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try{
      final response = await ApiProvider.instance().get(Endpoint.pinjam);
      if(response.statusCode == 200){
        final Responsepinjam responsePinjam = Responsepinjam.fromJson(response.data);
        if(responsePinjam.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responsePinjam.data, status: RxStatus.success());
        }
      }else{
        change(null, status: RxStatus.error("Gagal Mengambil Data"));
      }
    }on DioException catch (e){
      change(null, status: RxStatus.error("Error ${e.message}"));
    }catch(e){
      change(null, status: RxStatus.error("Error : $e"));
    }
  }

}
