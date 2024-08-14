import 'package:api2/Dio/model/dio_model.dart';
import 'package:api2/Dio/service/dio_service.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DioController extends GetxController {
  RxList<Dioproject> datas = RxList();
  RxBool isLoading = true.obs;
  RxBool isListDown = false.obs;
  RxBool isNetConnected = true.obs;

  var scrollController = ItemScrollController();

  //to check internet connectivity
  void isInternetConnected() async {
    isNetConnected.value = await InternetConnectionChecker().hasConnection;
  }

  //to fetch all the values from api
  fetchData() async {
    isInternetConnected();
    isLoading.value = true;
    var responseDio = await DioService().getData();
    if (responseDio.statusCode == 200) {
      responseDio.data.forEach((elements) {
        datas.add(Dioproject.fromJson(elements));
      });
      isLoading.value = false;
    }
  }

  /// goto end of the page
  scrollToUp() {
    scrollController.scrollTo(
        index: 0,
        duration: const Duration(seconds: 5),
        curve: Curves.slowMiddle);
    isListDown.value = false;
  }

  scrollToDown() {
    scrollController.scrollTo(
        index: datas.length,
        duration: const Duration(seconds: 5),
        curve: Curves.slowMiddle);
    isListDown.value = true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
    isInternetConnected();
  }
}
