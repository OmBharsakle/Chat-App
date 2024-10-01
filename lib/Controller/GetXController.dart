import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyGetXController extends GetxController{

  var isObscure=true.obs;
  var timeShoe=0.obs;

  void passShow()
  {
    isObscure.value=!isObscure.value;
  }

  void timeShow(int index)
  {
    timeShoe.value=index;
  }


  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  RxString receiverImage = "".obs;
  RxString imageShow = "".obs;
  TextEditingController txtMassage = TextEditingController();
  void getReceiver(String email, String name,String image) {
    receiverName.value = name;
    receiverEmail.value = email;
    receiverImage.value = image;
  }


}