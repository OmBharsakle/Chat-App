// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../Modal/ChatModel.dart';
// import '../../Screens/ChatScreen/Components/MessageWidget.dart';
//
// class ChatPage extends StatefulWidget {
//   final String currentUser;
//   final String chatPartner;
//
//   const ChatPage({Key? key, required this.currentUser, required this.chatPartner}) : super(key: key);
//
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   ChatModel? replyingToMessage; // Add a field to track the message being replied to
//
//   // Function to send a message
//   void sendMessage() {
//     if (messageController.text.isNotEmpty) {
//       FirebaseFirestore.instance.collection('chats').add({
//         'sender': widget.currentUser,
//         'receiver': widget.chatPartner,
//         'message': messageController.text,
//         'replyingTo': replyingToMessage?.message, // Add replied message if any
//         'time': Timestamp.now(),
//       }).then((_) {
//         _scrollToBottom();
//       });
//
//       setState(() {
//         messageController.clear();
//         replyingToMessage = null; // Clear the reply field after sending the message
//       });
//     }
//   }
//
//   // Function to scroll to the bottom of the ListView
//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToBottom();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with ${widget.chatPartner}'),
//       ),
//       body: Column(
//         children: [
//           // Reply Preview Box (if replying)
//           if (replyingToMessage != null)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               color: Colors.grey.shade200,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Replying to: ${replyingToMessage!.message}',
//                       style: TextStyle(color: Colors.black87),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () {
//                       setState(() {
//                         replyingToMessage = null; // Cancel reply
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .where('sender', isEqualTo: widget.currentUser)
//                   .where('receiver', isEqualTo: widget.chatPartner)
//                   .orderBy('time', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 var messages = snapshot.data!.docs;
//
//                 return ListView.builder(
//                   controller: _scrollController,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
//
//                     return Dismissible(
//                       key: Key(message.id),
//                       direction: DismissDirection.startToEnd, // Swipe right
//                       onDismissed: (direction) {
//                         setState(() {
//                           replyingToMessage = ChatModel.fromChat(
//                             message.data() as Map<String, dynamic>,
//                           ); // Set the message to reply to
//                         });
//                       },
//                       background: Container(
//                         color: Colors.blue.shade200,
//                         alignment: Alignment.centerLeft,
//                         padding: EdgeInsets.only(left: 20),
//                         child: Icon(Icons.reply, color: Colors.white),
//                       ),
//                       child: MessageWidget(
//                         message: ChatModel.fromChat(message.data() as Map<String, dynamic>),
//                         img: 'path_or_url_to_image',
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
