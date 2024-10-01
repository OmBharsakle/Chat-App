import 'package:chat_app/Modal/ChatModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../FireBase/AuthServices/SimpleAuth.dart';
import '../View/ChartPage.dart';

class MessageWidgetSender extends StatelessWidget {
  MessageWidgetSender({super.key, required  this.message,required this.img});

  ChatModel? message;

  var img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: message?.sender ==
            SimpleAuth.simpleAuth.getCurrentUser()!.email
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (message?.sender !=
              SimpleAuth.simpleAuth
                  .getCurrentUser()!
                  .email) ...[
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0 * 0.75,
              vertical: 16.0 / 2,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75, // Limiting message width
            ),
            decoration: BoxDecoration(
              color: message?.sender == SimpleAuth.simpleAuth.getCurrentUser()!.email
                  ? const Color(0xFF00BF6D) // Sender's message color
                  : Colors.grey.shade800.withOpacity(0.3), // Receiver's message color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: message?.sender == SimpleAuth.simpleAuth.getCurrentUser()!.email
                    ? Radius.circular(30)
                    : Radius.circular(0),
                bottomRight: message?.sender != SimpleAuth.simpleAuth.getCurrentUser()!.email
                    ? Radius.circular(30)
                    : Radius.circular(0),
              ),
            ),
            child: Text(
              '🚫 This message was deleted',
              style: const TextStyle(color: Colors.white, fontSize: 16,decoration: TextDecoration.none), // Text style
            ),
          ),
          if (message?.sender ==
              SimpleAuth.simpleAuth.getCurrentUser()!.email)
            MessageStatusDot(status: MessageStatus.viewed)
        ],
      ),
    );
  }
}
