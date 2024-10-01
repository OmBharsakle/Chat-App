import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Utils/Global.dart';

class ImageShowPage extends StatelessWidget {
  const ImageShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(image: NetworkImage(getX.imageShow.value),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: IconButton(onPressed: () {
              Get.back();
            }, icon: Icon(Icons.navigate_before,color: Colors.white,size: 40,)),
          ),
        ],
      ),
    );
  }
}