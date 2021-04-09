import 'package:get/get.dart';

class AuthRoleController extends GetxController{

  final selectedItem = 'stuff'.obs;

  void setSelected(String value){
    selectedItem.value = value;
  }
}