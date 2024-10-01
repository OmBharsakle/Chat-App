import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnLognPress extends StatelessWidget {
  const OnLognPress({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: <Widget>[
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
          child: const Text('Copy'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          trailingIcon: CupertinoIcons.share,
          child: const Text('Share'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          trailingIcon: CupertinoIcons.heart,
          child: const Text('Favorite'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          child: const Text('Delete'),
        ),
      ],
      child: const ColoredBox(
        color: CupertinoColors.systemYellow,
        child: FlutterLogo(size: 500.0),
      ),
    );
  }
}


//Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(
//                                           height: 10,
//                                           width: 10,
//                                         ),
//                                         GestureDetector(
//                                           onLongPress: () {
//                                             const OnLognPress();
//                                             showModalBottomSheet(
//                                               backgroundColor:
//                                                   Colors.transparent,
//                                               context: context,
//                                               builder: (context) {
//                                                 return Container(
//                                                   decoration: BoxDecoration(
//                                                       color: sheetColor,
//                                                       borderRadius:
//                                                           const BorderRadius
//                                                               .only(
//                                                               topLeft: Radius
//                                                                   .circular(30),
//                                                               topRight: Radius
//                                                                   .circular(
//                                                                       30))),
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           print(
//                                                               "Delete Receiver");
//                                                           //Todo Delete Receiver
//                                                           Get.back();
//                                                           showDialog(
//                                                             context: context,
//                                                             builder: (context) {
//                                                               return CupertinoAlertDialog(
//                                                                 title: const Text(
//                                                                   "Delete Conformation",
//                                                                 ),
//                                                                 content: const Text(
//                                                                     "Delete message Have you confirmed!!"),
//                                                                 actions: [
//                                                                   CupertinoDialogAction(
//                                                                       onPressed:
//                                                                           () {
//                                                                         Get.back();
//                                                                       },
//                                                                       child: const Text(
//                                                                           "No")),
//                                                                   CupertinoDialogAction(
//                                                                       onPressed:
//                                                                           () async {
//                                                                         Get.back();
//                                                                         String
//                                                                             dcId =
//                                                                             docIdList[index];
//                                                                         await FirebaseCloudServices.firebaseCloudServices.deleteChatReceiver(
//                                                                             getX.receiverEmail.value,
//                                                                             true,
//                                                                             dcId);
//                                                                       },
//                                                                       child: const Text(
//                                                                           "Yes")),
//                                                                 ],
//                                                               );
//                                                             },
//                                                           );
//                                                         },
//                                                         child: Container(
//                                                           width: width,
//                                                           alignment:
//                                                               Alignment.center,
//                                                           color: Colors
//                                                               .transparent,
//                                                           child: Center(
//                                                             child: Container(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8.0),
//                                                               margin:
//                                                                   const EdgeInsets
//                                                                       .all(15),
//                                                               child: Text(
//                                                                 "Delete",
//                                                                 style: TextStyle(
//                                                                     color:
//                                                                         textChanderColor,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         20),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: MessageWidget(
//                                             message: chatList[index],
//                                             img: widget.img,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 50,
//                                         ),
//                                       ],
//                                     )