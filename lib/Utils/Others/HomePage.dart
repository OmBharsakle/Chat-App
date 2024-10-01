import 'package:flutter/material.dart';
// TODO: add flutter_svg package to pubspec.yaml
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    paymentProcessIllistration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Hello and Welcome",
                description:
                "We're setting things up for you. This will only take a moment.",
                button: Transform.scale(
                  scale: 1.8,
                  child: const CircularProgressIndicator.adaptive(),
                ),
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

const paymentProcessIllistration = '''
<svg width="1080" height="1080" viewBox="0 0 1080 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M590.84 242.27H877.06C880.922 242.27 884.625 243.804 887.355 246.535C890.086 249.265 891.62 252.968 891.62 256.83V543C891.62 546.862 890.086 550.565 887.355 553.295C884.625 556.026 880.922 557.56 877.06 557.56H805.37C744.62 557.56 686.358 533.431 643.397 490.479C600.435 447.527 576.293 389.27 576.28 328.52V256.83C576.28 252.968 577.814 249.265 580.545 246.535C583.275 243.804 586.978 242.27 590.84 242.27Z" fill="#E5E5E5"/>
<path d="M270.444 736.1C275.627 720.148 266.897 703.015 250.945 697.832C234.993 692.649 217.86 701.378 212.677 717.33C207.494 733.282 216.224 750.416 232.176 755.599C248.128 760.782 265.261 752.052 270.444 736.1Z" fill="#E2E2E2"/>
<path d="M320.604 675.4C323.104 667.705 318.893 659.44 311.198 656.94C303.503 654.44 295.238 658.651 292.738 666.346C290.238 674.041 294.449 682.306 302.144 684.806C309.839 687.306 318.104 683.095 320.604 675.4Z" fill="#E2E2E2"/>
<path d="M220.94 658.42L182.76 630.24" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M235.32 647.7L228.22 634.87" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M250.88 643.74L254.21 605.75" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M391.35 766.91C443 684.73 495.94 512.78 505.11 412.34C505.282 404.783 508.398 397.591 513.794 392.298C519.191 387.004 526.441 384.027 534 384V384C541.665 384 549.016 387.045 554.435 392.465C559.855 397.884 562.9 405.235 562.9 412.9V714.26C552.9 758.54 534.99 800.12 477.08 801.67L453.67 840.88" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M507.52 656.43V558.58C507.52 551.236 510.437 544.193 515.63 539C520.823 533.807 527.866 530.89 535.21 530.89C538.846 530.89 542.447 531.606 545.807 532.998C549.166 534.389 552.219 536.429 554.79 539C557.361 541.572 559.401 544.624 560.792 547.984C562.184 551.343 562.9 554.944 562.9 558.58V656.42" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M370.77 769.02L463.36 878.91L434.95 912.74L337.49 797.06L370.77 769.02Z" fill="#E5E5E5"/>
<path d="M370.77 742.49L463.36 852.38L434.95 886.21L337.49 770.53L370.77 742.49Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M733.95 766.91C682.33 684.73 629.36 512.78 620.19 412.33C620.015 404.773 616.897 397.582 611.499 392.291C606.1 386.999 598.849 384.024 591.29 384V384C583.625 384 576.274 387.045 570.855 392.465C565.435 397.884 562.39 405.235 562.39 412.9V714.26C572.39 758.54 590.3 800.12 648.21 801.67L671.62 840.88" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M617.77 656.43V558.58C617.77 551.236 614.853 544.193 609.66 539C604.467 533.807 597.424 530.89 590.08 530.89V530.89C586.444 530.89 582.843 531.606 579.484 532.998C576.124 534.389 573.071 536.429 570.5 539C567.929 541.572 565.889 544.624 564.498 547.984C563.106 551.343 562.39 554.944 562.39 558.58V656.42" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M754.53 767.49L661.93 877.38L690.35 911.21L787.81 795.53L754.53 767.49Z" fill="#E5E5E5"/>
<path d="M754.53 742.49L661.93 852.38L690.35 886.21L787.81 770.53L754.53 742.49Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M524.65 350.05L462.06 269.05" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M561.06 345.64V182.05" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M597.05 345.64L662.72 279.97" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

// chat page

//import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../FireBase/AuthServices/SimpleAuth.dart';
// import '../../../FireBase/FireStore/UserStore.dart';
// import '../../../Modal/ChatModel.dart';
// import '../../../Utils/Global.dart';
// import '../Components/MessageWidget.dart';
//
// class MessagesScreen extends StatelessWidget {
//   MessagesScreen(
//       {super.key, required this.email, required this.name, required this.img});
//
//   String email, name, img;
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 80,
//         elevation: 0,
//         backgroundColor: const Color(0xFF00BF6D),
//         automaticallyImplyLeading: false,
//         leading: const BackButton(color: Colors.white),
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 22,
//               backgroundImage: img.startsWith('http')
//                   ? NetworkImage(img) // For network images
//                   : AssetImage(img) as ImageProvider, // For local assets
//               backgroundColor: Colors.grey[200],
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   StreamBuilder(
//                     stream: FirebaseCloudServices.firebaseCloudServices
//                         .checkUserIsOnlineOrNot(email),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Text(
//                           "Error",
//                           style: TextStyle(color: Colors.redAccent),
//                         );
//                       }
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Text(
//                           "Connecting...",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         );
//                       }
//
//                       Map<String, dynamic>? user = snapshot.data?.data();
//                       if (user == null) {
//                         return const Text(
//                           "Offline",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         );
//                       }
//
//                       // Get user's online status
//                       bool isOnline = user['isOnline'];
//                       bool isTyping = user['isTyping'];
//                       DateTime lastSeen = user['timestamp'].toDate();
//
//                       String displayTime = lastSeen.hour > 11 ? 'PM' : 'AM';
//                       String lastSeenTime =
//                           '${lastSeen.hour % 12}:${lastSeen.minute.toString().padLeft(2, '0')} $displayTime';
//
//                       return Text(
//                         isOnline
//                             ? (isTyping ? 'Typing...' : 'Online')
//                             : 'Last seen at $lastSeenTime',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.local_phone, color: Colors.white),
//             onPressed: () {
//               // Add phone call logic
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.videocam, color: Colors.white),
//             onPressed: () {
//               // Add video call logic
//             },
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: StreamBuilder(
//                 stream: FirebaseCloudServices.firebaseCloudServices
//                     .readChatFromFireStore(getX.receiverEmail.value),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Center(child: Text(snapshot.error.toString()));
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   List data = snapshot.data!.docs;
//                   List<ChatModel> chatList = [];
//                   List docIdList = [];
//                   for (QueryDocumentSnapshot snap in data) {
//                     docIdList.add(snap.id);
//                     chatList.add(ChatModel.fromChat(snap.data() as Map));
//                   }
//                   return ListView.builder(
//                     itemCount: chatList.length,
//                     itemBuilder: (context, index) {
//                       // return (chatList[index].sender!=SimpleAuth.simpleAuth.getCurrentUser()!.email)?ListTile(title: Text(chatList[index].message!)):ListTile(trailing: Text(chatList[index].message!));
//                       return (chatList[index].sender !=
//                           SimpleAuth.simpleAuth.getCurrentUser()!.email!)
//                           ? (chatList[index].deleteReceiver == true)
//                           ? Container()
//                           : (chatList[index].delete == true)
//                           ? Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             onLongPress: () {
//                               showModalBottomSheet(
//                                 backgroundColor:
//                                 Colors.transparent,
//                                 context: context,
//                                 builder: (context) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         color: sheetColor,
//                                         borderRadius:
//                                         const BorderRadius
//                                             .only(
//                                             topLeft: Radius
//                                                 .circular(30),
//                                             topRight: Radius
//                                                 .circular(
//                                                 30))),
//                                     child: Column(
//                                       mainAxisSize:
//                                       MainAxisSize.min,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             print(
//                                                 "Delete Receiver");
//                                             //Todo Delete Receiver
//                                             Get.back();
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CupertinoAlertDialog(
//                                                   title: Text(
//                                                     "Delete Conformation",
//                                                   ),
//                                                   content: const Text(
//                                                       "Delete message Have you confirmed!!"),
//                                                   actions: [
//                                                     CupertinoDialogAction(
//                                                         onPressed:
//                                                             () {
//                                                           Get.back();
//                                                         },
//                                                         child: Text(
//                                                             "No")),
//                                                     CupertinoDialogAction(
//                                                         onPressed:
//                                                             () async {
//                                                           Get.back();
//                                                           String
//                                                           dcId =
//                                                           docIdList[index];
//                                                           await FirebaseCloudServices.firebaseCloudServices.deleteChatReceiver(
//                                                               getX.receiverEmail.value,
//                                                               true,
//                                                               dcId);
//                                                         },
//                                                         child: Text(
//                                                             "Yes")),
//
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: MessageWidget(message: chatList[index],img: img,),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 12,
//                                   backgroundImage: img!.startsWith('http')
//                                       ? NetworkImage(img) // For network images
//                                       : AssetImage(img) as ImageProvider,
//                                   // For local assets
//                                   backgroundColor: Colors.grey[
//                                   200], // Add a background color in case image is not found
//                                 ),
//                                 const SizedBox(width: 16.0 / 2),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0 * 0.75,
//                                     vertical: 16.0 / 2,
//                                   ),
//                                   constraints: BoxConstraints(
//                                     maxWidth: MediaQuery.of(context).size.width * 0.75, // Limiting message width
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade800.withOpacity(0.3), // Receiver's message color
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(30),
//                                       topRight: Radius.circular(30),
//                                       bottomLeft: Radius.circular(0),
//                                       bottomRight:  Radius.circular(30),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'You deleted Message',
//                                     style: const TextStyle(color: Colors.white, fontSize: 16,decorationStyle: TextDecorationStyle.dotted), // Text style
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 50,
//                           ),
//                         ],
//                       )
//                           : Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             onLongPress: () {
//                               showModalBottomSheet(
//                                 backgroundColor:
//                                 Colors.transparent,
//                                 context: context,
//                                 builder: (context) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         color: sheetColor,
//                                         borderRadius:
//                                         const BorderRadius
//                                             .only(
//                                             topLeft: Radius
//                                                 .circular(30),
//                                             topRight: Radius
//                                                 .circular(
//                                                 30))),
//                                     child: Column(
//                                       mainAxisSize:
//                                       MainAxisSize.min,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             print(
//                                                 "Delete Receiver");
//                                             //Todo Delete Receiver
//                                             Get.back();
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CupertinoAlertDialog(
//                                                   title: Text(
//                                                     "Delete Conformation",
//                                                   ),
//                                                   content: const Text(
//                                                       "Delete message Have you confirmed!!"),
//                                                   actions: [
//                                                     CupertinoDialogAction(
//                                                         onPressed:
//                                                             () {
//                                                           Get.back();
//                                                         },
//                                                         child: Text(
//                                                             "No")),
//                                                     CupertinoDialogAction(
//                                                         onPressed:
//                                                             () async {
//                                                           Get.back();
//                                                           String
//                                                           dcId =
//                                                           docIdList[index];
//                                                           await FirebaseCloudServices.firebaseCloudServices.deleteChatReceiver(
//                                                               getX.receiverEmail.value,
//                                                               true,
//                                                               dcId);
//                                                         },
//                                                         child: Text(
//                                                             "Yes")),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: Container(
//                                             width: width,
//                                             alignment:
//                                             Alignment.center,
//                                             color: Colors
//                                                 .transparent,
//                                             child: Center(
//                                               child: Container(
//                                                 padding:
//                                                 const EdgeInsets
//                                                     .all(8.0),
//                                                 margin:
//                                                 const EdgeInsets
//                                                     .all(15),
//                                                 child: Text(
//                                                   "Delete",
//                                                   style: TextStyle(
//                                                       color:
//                                                       textChanderColor,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .bold,
//                                                       fontSize:
//                                                       20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: MessageWidget(message: chatList[index],img: img,),
//                           ),
//                           const SizedBox(
//                             height: 50,
//                           ),
//                         ],
//                       )
//                           : (chatList[index].delete == true &&
//                           chatList[index].deleteSender)
//                           ? Container()
//                           : (chatList[index].delete == true)
//                           ? Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             onLongPress: () {
//                               showModalBottomSheet(
//                                 backgroundColor:
//                                 Colors.transparent,
//                                 context: context,
//                                 builder: (context) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         color: sheetColor,
//                                         borderRadius:
//                                         const BorderRadius
//                                             .only(
//                                             topLeft: Radius
//                                                 .circular(30),
//                                             topRight: Radius
//                                                 .circular(
//                                                 30))),
//                                     child: Column(
//                                       mainAxisSize:
//                                       MainAxisSize.min,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             print(
//                                                 "Delete Receiver");
//                                             //Todo Delete Receiver
//                                             Get.back();
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return CupertinoAlertDialog(
//                                                   title: Text(
//                                                     "Delete Conformation",
//                                                   ),
//                                                   content: const Text(
//                                                       "Delete message Have you confirmed!!"),
//                                                   actions: [
//                                                     CupertinoDialogAction(
//                                                         onPressed:
//                                                             () {
//                                                           Get.back();
//                                                         },
//                                                         child: Text(
//                                                             "No")),
//                                                     CupertinoDialogAction(
//                                                         onPressed:
//                                                             () async {
//                                                           Get.back();
//                                                           String
//                                                           dcId =
//                                                           docIdList[index];
//                                                           await FirebaseCloudServices.firebaseCloudServices.deleteChatSenderMe(
//                                                               getX.receiverEmail.value,
//                                                               true,
//                                                               dcId);
//                                                         },
//                                                         child: Text(
//                                                             "Yes")),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: Container(
//                                             width: width,
//                                             alignment:
//                                             Alignment.center,
//                                             color: Colors
//                                                 .transparent,
//                                             child: Center(
//                                               child: Container(
//                                                 padding:
//                                                 const EdgeInsets
//                                                     .all(8.0),
//                                                 margin:
//                                                 const EdgeInsets
//                                                     .all(15),
//                                                 child: Text(
//                                                   "Delete",
//                                                   style: TextStyle(
//                                                       color:
//                                                       textChanderColor,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .bold,
//                                                       fontSize:
//                                                       20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0 * 0.75,
//                                     vertical: 16.0 / 2,
//                                   ),
//                                   constraints: BoxConstraints(
//                                     maxWidth: MediaQuery.of(context).size.width * 0.75, // Limiting message width
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFF00BF6D), // Receiver's message color
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(30),
//                                       topRight: Radius.circular(30),
//                                       bottomLeft: Radius.circular(30),
//                                       bottomRight:  Radius.circular(0),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'You deleted Message',
//                                     style: const TextStyle(color: Colors.white, fontSize: 16,decorationStyle: TextDecorationStyle.dotted), // Text style
//                                   ),
//                                 ),
//                                 if (chatList[index]?.sender ==
//                                     SimpleAuth.simpleAuth.getCurrentUser()!.email)
//                                   MessageStatusDot(status: MessageStatus.viewed)
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 50,
//                             width: 10,
//                           ),
//                         ],
//                       )
//                           : (chatList[index].deleteSender == true)
//                           ? Container()
//                           : Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.end,
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             onLongPress: () {
//                               showModalBottomSheet(
//                                 backgroundColor:
//                                 Colors.transparent,
//                                 context: context,
//                                 builder: (context) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         color: sheetColor,
//                                         borderRadius:
//                                         const BorderRadius
//                                             .only(
//                                             topLeft: Radius
//                                                 .circular(
//                                                 30),
//                                             topRight: Radius
//                                                 .circular(
//                                                 30))),
//                                     child: Column(
//                                       mainAxisSize:
//                                       MainAxisSize.min,
//                                       children: [
//                                         Center(
//                                           child:
//                                           GestureDetector(
//                                             onTap: () {
//                                               print("Update");
//                                               Navigator.of(
//                                                   context)
//                                                   .pop();
//                                               showDialog(
//                                                 context:
//                                                 context,
//                                                 builder:
//                                                     (context) {
//                                                   TextEditingController
//                                                   textUpdate =
//                                                   TextEditingController(
//                                                       text:
//                                                       chatList[index].message);
//                                                   return AlertDialog(
//                                                     backgroundColor:
//                                                     sheetColor,
//                                                     title: Center(
//                                                         child: Text(
//                                                           "Edit Message",
//                                                           style:
//                                                           TextStyle(
//                                                             color:
//                                                             textChanderColor,
//                                                           ),
//                                                         )),
//                                                     content:
//                                                     Container(
//                                                       decoration: BoxDecoration(
//                                                           color:
//                                                           textFieldContainer,
//                                                           borderRadius:
//                                                           BorderRadius.circular(50)),
//                                                       child:
//                                                       TextField(
//                                                         controller:
//                                                         textUpdate,
//                                                         style:
//                                                         TextStyle(color: textStyleColor),
//                                                         decoration:
//                                                         InputDecoration(
//                                                           border:
//                                                           OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50)),
//                                                           enabledBorder:
//                                                           OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50)),
//                                                           focusedBorder:
//                                                           OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(50)),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     actions: [
//                                                       TextButton(
//                                                           onPressed:
//                                                               () {
//                                                             Get.back();
//                                                           },
//                                                           child:
//                                                           Text(
//                                                             "Exit",
//                                                             style: TextStyle(color: textChanderColor),
//                                                           )),
//                                                       TextButton(
//                                                         onPressed:
//                                                             () async {
//                                                           Get.back();
//                                                           //todo confirmation for update text....
//                                                           String
//                                                           dcId =
//                                                           docIdList[index];
//                                                           await FirebaseCloudServices.firebaseCloudServices.updateChat(
//                                                               getX.receiverEmail.value,
//                                                               textUpdate.text,
//                                                               dcId);
//                                                         },
//                                                         child:
//                                                         Text(
//                                                           "Confirm",
//                                                           style:
//                                                           TextStyle(color: textChanderColor),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                             child: Container(
//                                               width: width,
//                                               alignment:
//                                               Alignment
//                                                   .center,
//                                               color: Colors
//                                                   .transparent,
//                                               padding:
//                                               const EdgeInsets
//                                                   .all(
//                                                   8.0),
//                                               margin:
//                                               const EdgeInsets
//                                                   .all(
//                                                   15),
//                                               child: Text(
//                                                 "Edit Message",
//                                                 style: TextStyle(
//                                                     color:
//                                                     textChanderColor,
//                                                     fontWeight:
//                                                     FontWeight
//                                                         .bold,
//                                                     fontSize:
//                                                     20),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             print("Delete");
//                                             Get.back();
//                                             showDialog(
//                                               context:
//                                               context,
//                                               builder:
//                                                   (context) {
//                                                 return AlertDialog(
//                                                   backgroundColor:
//                                                   sheetColor,
//                                                   content:
//                                                   Text(
//                                                     "Delete Message?",
//                                                     style: TextStyle(
//                                                         color:
//                                                         textSheetDeleteColor),
//                                                   ),
//                                                   actions: [
//                                                     Column(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                       mainAxisSize:
//                                                       MainAxisSize.min,
//                                                       children: [
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                           // mainAxisSize: MainAxisSize.min,
//                                                           children: [
//                                                             TextButton(
//                                                               onPressed: () async {
//                                                                 Get.back();
//                                                                 String dcId = docIdList[index];
//                                                                 await FirebaseCloudServices.firebaseCloudServices.deleteChatSenderAlso(getX.receiverEmail.value, true, dcId);
//                                                               },
//                                                               child: Text("Delete For Everyone", textAlign: TextAlign.end, style: TextStyle(color: textButtonColor, fontWeight: FontWeight.bold)),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                           // mainAxisSize: MainAxisSize.min,
//                                                           children: [
//                                                             TextButton(
//                                                               onPressed: () async {
//                                                                 Get.back();
//                                                                 String dcId = docIdList[index];
//                                                                 await FirebaseCloudServices.firebaseCloudServices.deleteChatSenderMe(getX.receiverEmail.value, true, dcId);
//                                                               },
//                                                               child: Text(
//                                                                 "Delete For Me",
//                                                                 textAlign: TextAlign.end,
//                                                                 style: TextStyle(color: textButtonColor, fontWeight: FontWeight.bold),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                           // mainAxisSize: MainAxisSize.min,
//                                                           children: [
//                                                             TextButton(
//                                                               onPressed: () {
//                                                                 Get.back();
//                                                               },
//                                                               child: Text(
//                                                                 "close",
//                                                                 textAlign: TextAlign.end,
//                                                                 style: TextStyle(
//                                                                   color: textButtonColor,
//                                                                   fontWeight: FontWeight.bold,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: Container(
//                                             width: width,
//                                             alignment:
//                                             Alignment
//                                                 .center,
//                                             color: Colors
//                                                 .transparent,
//                                             child: Center(
//                                               child:
//                                               Container(
//                                                 padding:
//                                                 const EdgeInsets
//                                                     .all(
//                                                     8.0),
//                                                 margin:
//                                                 const EdgeInsets
//                                                     .all(
//                                                     15),
//                                                 child: Text(
//                                                   "Delete",
//                                                   style: TextStyle(
//                                                       color:
//                                                       textChanderColor,
//                                                       fontWeight:
//                                                       FontWeight
//                                                           .bold,
//                                                       fontSize:
//                                                       20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: MessageWidget(message: chatList[index],img: img,),
//                           ),
//                           const SizedBox(
//                             height: 50,
//                             width: 10,
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//           const ChatInputField(),
//         ],
//       ),
//     );
//   }
// }
//
// class ChatInputField extends StatefulWidget {
//   const ChatInputField({super.key});
//
//   @override
//   State<ChatInputField> createState() => _ChatInputFieldState();
// }
//
// class _ChatInputFieldState extends State<ChatInputField> {
//   bool _showAttachment = false;
//
//   void _updateAttachmentState() {
//     setState(() {
//       _showAttachment = !_showAttachment;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16.0,
//         vertical: 16.0 / 2,
//       ),
//       // margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, -4),
//             blurRadius: 32,
//             color: const Color(0xFF087949).withOpacity(0.08),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 16.0 / 4),
//                       Expanded(
//                         child: TextField(
//                           controller: getX.txtMassage,
//                           onChanged: (value) {
//                             // When user starts typing, toggle isTyping status to true
//                             FirebaseCloudServices.firebaseCloudServices
//                                 .toggleOnlineStatus(
//                               true,
//                               Timestamp.now(),
//                               true,
//                             );
//                           },
//                           onTapOutside: (event) {
//                             // When user taps outside the text field, toggle isTyping status to false
//                             FirebaseCloudServices.firebaseCloudServices
//                                 .toggleOnlineStatus(
//                               true,
//                               Timestamp.now(),
//                               false,
//                             );
//                           },
//                           style: TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             hintText: "Type message",
//                             suffixIcon: SizedBox(
//                               width: 65,
//                               child: Row(
//                                 children: [
//                                   InkWell(
//                                     onTap: _updateAttachmentState,
//                                     child: Icon(
//                                       Icons.attach_file,
//                                       color: _showAttachment
//                                           ? const Color(0xFF00BF6D)
//                                           : Theme.of(context)
//                                               .textTheme
//                                               .bodyLarge!
//                                               .color!
//                                               .withOpacity(0.64),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16.0 / 2),
//                                     child: Icon(
//                                       Icons.camera_alt_outlined,
//                                       color: Theme.of(context)
//                                           .textTheme
//                                           .bodyLarge!
//                                           .color!
//                                           .withOpacity(0.64),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 const Color(0xFF00BF6D).withOpacity(0.08),
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0 * 1.5, vertical: 16.0),
//                             border: const OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(50)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 16.0),
//                 IconButton(
//                     onPressed: () async {
//                       if (getX.txtMassage.text.trim().isNotEmpty) {
//                         ChatModel chat = ChatModel(
//                           sender: SimpleAuth.simpleAuth.getCurrentUser()!.email,
//                           receiver: getX.receiverEmail.value,
//                           message: getX.txtMassage.text,
//                           time: Timestamp.now(),
//                           editTime: Timestamp.now(),
//                           edit: false,
//                           delete: false,
//                           deleteSender: false,
//                           deleteReceiver: false,
//                         );
//
//                         await FirebaseCloudServices.firebaseCloudServices
//                             .addChatFireStore(chat);
//                         await FirebaseCloudServices.firebaseCloudServices
//                             .lastMessageStore(
//                           getX.receiverEmail.value,
//                           getX.txtMassage.text,
//                           Timestamp.now(),
//                         );
//                         // Clear the text field after sending the message
//                         getX.txtMassage.clear();
//                       }
//                     },
//                     icon: Icon(Icons.send)),
//               ],
//             ),
//             if (_showAttachment) const MessageAttachment(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MessageAttachment extends StatelessWidget {
//   const MessageAttachment({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       // color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           MessageAttachmentCard(
//             iconData: Icons.insert_drive_file,
//             title: "Document",
//             press: () {},
//           ),
//           MessageAttachmentCard(
//             iconData: Icons.image,
//             title: "Gallary",
//             press: () {},
//           ),
//           MessageAttachmentCard(
//             iconData: Icons.headset,
//             title: "Audio",
//             press: () {},
//           ),
//           MessageAttachmentCard(
//             iconData: Icons.videocam,
//             title: "Video",
//             press: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MessageAttachmentCard extends StatelessWidget {
//   final VoidCallback press;
//   final IconData iconData;
//   final String title;
//
//   const MessageAttachmentCard(
//       {super.key,
//       required this.press,
//       required this.iconData,
//       required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: press,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0 / 2),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16.0 * 0.75),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF00BF6D),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 iconData,
//                 size: 20,
//                 color: Theme.of(context).scaffoldBackgroundColor,
//               ),
//             ),
//             const SizedBox(height: 16.0 / 2),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                     color: Theme.of(context)
//                         .textTheme
//                         .bodyLarge!
//                         .color!
//                         .withOpacity(0.8),
//                   ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Message extends StatelessWidget {
//   const Message({
//     super.key,
//     required this.message,
//   });
//
//   final ChatMessage message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: Row(
//         mainAxisAlignment:
//             message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!message.isSender) ...[
//             const CircleAvatar(
//               radius: 12,
//               backgroundImage:
//                   NetworkImage("https://i.postimg.cc/cCsYDjvj/user-2.png"),
//             ),
//             const SizedBox(width: 16.0 / 2),
//           ],
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0 * 0.75,
//               vertical: 16.0 / 2,
//             ),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00BF6D)
//                   .withOpacity(message!.isSender ? 1 : 0.1),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               message!.text,
//               style: TextStyle(
//                 color: message!.isSender
//                     ? Colors.white
//                     : Theme.of(context).textTheme.bodyLarge!.color,
//               ),
//             ),
//           ),
//           if (message.isSender) MessageStatusDot(status: message.messageStatus)
//         ],
//       ),
//     );
//   }
// }
//
// class VideoMessage extends StatelessWidget {
//   const VideoMessage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
//       child: AspectRatio(
//         aspectRatio: 1.6,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                   "https://i.postimg.cc/Ls1WtygL/Video-Place-Here.png"),
//             ),
//             Container(
//               height: 25,
//               width: 25,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF00BF6D),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.play_arrow,
//                 size: 16,
//                 color: Colors.white,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AudioMessage extends StatelessWidget {
//   final ChatMessage? message;
//
//   const AudioMessage({super.key, this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.55,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16.0 * 0.75,
//         vertical: 16.0 / 2.5,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         color: const Color(0xFF00BF6D).withOpacity(message!.isSender ? 1 : 0.1),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.play_arrow,
//             color: message!.isSender ? Colors.white : const Color(0xFF00BF6D),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0 / 2),
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 2,
//                     color: message!.isSender
//                         ? Colors.white
//                         : const Color(0xFF00BF6D).withOpacity(0.4),
//                   ),
//                   Positioned(
//                     left: 0,
//                     child: Container(
//                       height: 8,
//                       width: 8,
//                       decoration: BoxDecoration(
//                         color: message!.isSender
//                             ? Colors.white
//                             : const Color(0xFF00BF6D),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Text(
//             "0.37",
//             style: TextStyle(
//                 fontSize: 12, color: message!.isSender ? Colors.white : null),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class TextMessage extends StatelessWidget {
//   const TextMessage({
//     super.key,
//     this.message,
//   });
//
//   final ChatMessage? message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16.0 * 0.75,
//         vertical: 16.0 / 2,
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xFF00BF6D).withOpacity(message!.isSender ? 1 : 0.1),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Text(
//         message!.text,
//         style: TextStyle(
//           color: message!.isSender
//               ? Colors.white
//               : Theme.of(context).textTheme.bodyLarge!.color,
//         ),
//       ),
//     );
//   }
// }
//
// class MessageStatusDot extends StatelessWidget {
//   final MessageStatus? status;
//
//   const MessageStatusDot({super.key, this.status});
//
//   @override
//   Widget build(BuildContext context) {
//     Color dotColor(MessageStatus status) {
//       switch (status) {
//         case MessageStatus.notSent:
//           return const Color(0xFFF03738);
//         case MessageStatus.notView:
//           return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
//         case MessageStatus.viewed:
//           return const Color(0xFF00BF6D);
//         default:
//           return Colors.transparent;
//       }
//     }
//
//     return Container(
//       margin: const EdgeInsets.only(left: 16.0 / 2),
//       height: 12,
//       width: 12,
//       decoration: BoxDecoration(
//         color: dotColor(status!),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         status == MessageStatus.notSent ? Icons.close : Icons.done,
//         size: 8,
//         color: Theme.of(context).scaffoldBackgroundColor,
//       ),
//     );
//   }
// }
//
// enum ChatMessageType { text, audio, image, video }
//
// enum MessageStatus { notSent, notView, viewed }
//
// class ChatMessage {
//   final String text;
//   final ChatMessageType messageType;
//   final MessageStatus messageStatus;
//   final bool isSender;
//
//   ChatMessage({
//     this.text = '',
//     required this.messageType,
//     required this.messageStatus,
//     required this.isSender,
//   });
// }
