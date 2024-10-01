import 'package:chat_app/Modal/ChatModel.dart';
import 'package:chat_app/Utils/Global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../../FireBase/AuthServices/SimpleAuth.dart';
import '../../../FireBase/FireStore/UserStore.dart';
import '../View/ChartPage.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({super.key, required this.message, required this.img, required this.docIdList,required this.index});

  ChatModel? message;

  var img;
  var index;
  var docIdList;

  @override
  Widget build(BuildContext context) {
    DateTime? messageTime = message?.time.toDate();
    String formattedTime = DateFormat('hh:mm a').format(messageTime!);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment:
            message?.sender == SimpleAuth.simpleAuth.getCurrentUser()!.email
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: <Widget>[
          if (message?.sender !=
              SimpleAuth.simpleAuth.getCurrentUser()!.email) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: img!.startsWith('http')
                  ? NetworkImage(img) // For network images
                  : AssetImage(img) as ImageProvider,
              // For local assets
              backgroundColor: Colors.grey[
                  200], // Add a background color in case image is not found
            ),
            const SizedBox(width: 16.0 / 2),
          ],
          // (message?.sender ==
          //     SimpleAuth.simpleAuth.getCurrentUser()!.email)
          //     ?
          // Row(children: [
          //   CircleAvatar(radius: 10,backgroundImage: AssetImage('assets/3.png'),),SizedBox(width: 8,),],)
          //     :Container(),
          Obx(
            () => GestureDetector(
              onTap: () {
                getX.passShow();
                getX.timeShow(index);
              },
              child: Column(
                crossAxisAlignment:
                message?.sender == SimpleAuth.simpleAuth.getCurrentUser()!.email
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  message!.massageType == "massage"
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 0.75,
                            vertical: 16.0 / 2,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width *
                                0.75, // Limiting message width
                          ),
                          decoration: BoxDecoration(
                            color: message?.sender ==
                                    SimpleAuth.simpleAuth
                                        .getCurrentUser()!
                                        .email
                                ? const Color(
                                    0xFF00BF6D) // Sender's message color
                                : Colors.grey.shade800.withOpacity(0.3),
                            // Receiver's message color
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: message?.sender ==
                                      SimpleAuth.simpleAuth
                                          .getCurrentUser()!
                                          .email
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                              bottomRight: message?.sender !=
                                      SimpleAuth.simpleAuth
                                          .getCurrentUser()!
                                          .email
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                            ),
                          ),
                          child: Text(
                            message!.message.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.none), // Text style
                          ))
                      : Container(
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: message?.sender ==
                                      SimpleAuth.simpleAuth
                                          .getCurrentUser()!
                                          .email
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                              bottomRight: message?.sender !=
                                      SimpleAuth.simpleAuth
                                          .getCurrentUser()!
                                          .email
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: message?.sender ==
                                      SimpleAuth.simpleAuth
                                          .getCurrentUser()!
                                          .email
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                              bottomRight: message?.sender !=
                                      SimpleAuth.simpleAuth
                                          .getCurrentUser()!
                                          .email
                                  ? Radius.circular(30)
                                  : Radius.circular(0),
                            ),
                            child: FadeInImage(
                              placeholder: AssetImage('assets/lodding.gif'),
                              image: NetworkImage(
                                message!.message.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          )),
                  //Show Time Message
                  getX.isObscure.value
                      ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                                            formattedTime,
                            style: TextStyle(fontSize: 10,decoration: TextDecoration.none),
                          ),
                      )
                      : Container(),
                ],
              ),
            ),
          ),
          // (message?.sender !=
          //     SimpleAuth.simpleAuth.getCurrentUser()!.email)
          //   ?
          //     Row(children: [SizedBox(width: 8,),
          //       CircleAvatar(radius: 10,backgroundImage: AssetImage('assets/3.png'),),],)
          //   :Container(),

          if (message?.sender == SimpleAuth.simpleAuth.getCurrentUser()!.email)
            message?.readAndUnReadMassage == false? MessageStatusDot(status: MessageStatus.notSent):MessageStatusDot(status: MessageStatus.viewed)
        ],
      ),
    );
  }
}
