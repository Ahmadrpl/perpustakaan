import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:petugas/app/data/model/responsebook.dart';
import 'package:petugas/app/data/model/responsepinjam.dart';
import '../../../data/constan/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class BookController extends GetxController with StateMixin<List<databook>>{
  //TODO: Implement BookController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
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
  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try{
      final response = await ApiProvider.instance().get(Endpoint.book);
      if(response.statusCode == 200){
        final Responsebook responseBook = Responsebook.fromJson(response.data);
        if(responseBook.data!.isEmpty){
          change(null, status: RxStatus.empty());
        } else {
          change(response.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    }on DioException catch(e){
      change(null, status: RxStatus.error("Error ${e.message}"));
    }catch(e){
      change(null, status: RxStatus.error("Error : $e"));
    }

  }
}