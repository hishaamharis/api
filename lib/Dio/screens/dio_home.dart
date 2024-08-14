import 'package:api2/Dio/controller/dio_controller.dart';
import 'package:api2/Dio/utils/colors.dart';
import 'package:api2/Dio/utils/const_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: DioHome(),
  ));
}

class DioHome extends StatelessWidget {
  DioController controller = Get.put(DioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Mycolors.scColor,
      ),
      backgroundColor: Mycolors.bgColor,
      floatingActionButton:
      Obx(() => controller.isNetConnected.value ? buildFAB() : Container()),
      body: Obx(() =>
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: controller.isNetConnected.value == true
                ? (controller.isLoading.value
                ? Center(
              child: Lottie.asset("name", height: 200, width: 200),
            )
                : getDetails())
                : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("name"),
                  MaterialButton(onPressed: () async {
                    if (await InternetConnectionChecker().hasConnection ==
                        true) {
                      controller.fetchData();
                    } else {
                      showCustomSnackBar(context);
                    }
                  })
                ],
              ),
            ),
          )),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        controller.isListDown.value
            ? controller.scrollToUp()
            : controller.scrollToDown();
      },
      child: FaIcon(controller.isListDown.value
          ? FontAwesomeIcons.arrowUp
          : FontAwesomeIcons.arrowDown),
    );
  }

  RefreshIndicator getDetails() {
    return RefreshIndicator(
        onRefresh: () {
          return controller.fetchData();
        },
        child: ScrollablePositionedList.builder(
            itemScrollController: controller.scrollController,
            itemCount: controller.datas.length,
            itemBuilder: (context, index) {
              final data = controller.datas[index];
              return Card(
                child: ListTile(
                  leading: Text(data.id.toString()),
                  title: Text(data.title),
                  subtitle: Text(data.body),
                ),
              );
            }));
  }
}
