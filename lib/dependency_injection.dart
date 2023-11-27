import 'package:get/get.dart';
import 'package:quebra_cabecas/controller/network_controller.dart';

class DependencyInjection{

  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}