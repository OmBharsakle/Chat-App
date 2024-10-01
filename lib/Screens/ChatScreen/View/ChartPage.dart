import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../FireBase/AuthServices/SimpleAuth.dart';
import '../../../FireBase/FireStore/UserStore.dart';
import '../../../FireBase/Storage/FireBaseStorage.dart';
import '../../../Modal/ChatModel.dart';
import '../../../Modal/MessageTypeModal.dart';
import '../../../Utils/Global.dart';
import '../Components/DeletedMessageReceiver.dart';
import '../Components/DeletedMessageSender.dart';
import '../Components/MessageWidget.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen(
      {super.key, required this.email, required this.name, required this.img});

  String email, name, img;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        automaticallyImplyLeading: false,
        leading: const BackButton(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: widget.img.startsWith('http')
                  ? NetworkImage(widget.img) // For network images
                  : AssetImage(widget.img) as ImageProvider, // For local assets
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.capitalizeFirst!.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  StreamBuilder(
                    stream: FirebaseCloudServices.firebaseCloudServices
                        .checkUserIsOnlineOrNot(widget.email),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                          "Error",
                          style: TextStyle(color: Colors.redAccent),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Connecting...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        );
                      }

                      Map<String, dynamic>? user = snapshot.data?.data();
                      if (user == null) {
                        return const Text(
                          "Offline",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        );
                      }

                      // Get user's online status
                      bool isOnline = user['isOnline'];
                      bool isTyping = user['isTyping'];
                      DateTime lastSeen = user['timestamp'].toDate();
                      String displayTime = lastSeen.hour > 11 ? 'PM' : 'AM';
                      String lastSeenTime =
                          '${lastSeen.hour % 12}:${lastSeen.minute.toString().padLeft(2, '0')} $displayTime';

                      return Text(
                        isOnline
                            ? (isTyping ? 'Typing...' : 'Online')
                            : 'Last seen at $lastSeenTime',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_phone, color: Colors.white),
            onPressed: () {
              // Get.to(ChatPage(currentUser: SimpleAuth.simpleAuth.getCurrentUser()!.email!,chatPartner: ,));
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              // Add video call logic
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: StreamBuilder(
                stream: FirebaseCloudServices.firebaseCloudServices
                    .readChatFromFireStore(getX.receiverEmail.value),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List data = snapshot.data!.docs;
                  List<ChatModel> chatList = [];
                  List docIdList = [];
                  for (QueryDocumentSnapshot snap in data) {
                    docIdList.add(snap.id);
                    chatList.add(ChatModel.fromChat(snap.data() as Map));
                  }
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToBottom();
                  });

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      if (chatList[index].sender !=
                          SimpleAuth.simpleAuth.getCurrentUser()!.email) {
                        FirebaseCloudServices.firebaseCloudServices.userReadAndUnRead(
                            getX.receiverEmail.value, true, docIdList[index]);
                      }
                      // return (chatList[index].sender!=SimpleAuth.simpleAuth.getCurrentUser()!.email)?ListTile(title: Text(chatList[index].message!)):ListTile(trailing: Text(chatList[index].message!));
                      return (chatList[index].sender !=
                              SimpleAuth.simpleAuth.getCurrentUser()!.email!)
                          ? (chatList[index].deleteReceiver == true)
                              ? Container()
                              : (chatList[index].delete == true)
                                  ? GestureDetector(
                                      onLongPress: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30))),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CupertinoAlertDialog(
                                                            title: const Text(
                                                              "Delete Conformation",
                                                            ),
                                                            content: const Text(
                                                                "Delete message Have you confirmed!!"),
                                                            actions: [
                                                              CupertinoDialogAction(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "No")),
                                                              CupertinoDialogAction(
                                                                  onPressed:
                                                                      () async {
                                                                    Get.back();
                                                                    String
                                                                        dcId =
                                                                        docIdList[
                                                                            index];
                                                                    await FirebaseCloudServices
                                                                        .firebaseCloudServices
                                                                        .deleteChatReceiver(
                                                                            getX.receiverEmail.value,
                                                                            true,
                                                                            dcId);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "Yes")),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: MessageWidget(
                                                      message: chatList[index],
                                                      img: widget.img,
                                                      index: index,
                                                      docIdList:
                                                          docIdList[index],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: MessageWidgetSender(
                                        message: chatList[index],
                                        img: widget.img,
                                      ),
                                    )
                                  : CupertinoContextMenu(
                                      actions: <Widget>[
                                        CupertinoContextMenuAction(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the context menu
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: const Text(
                                                      "Delete Confirmation"),
                                                  content: const Text(
                                                      "Are you sure you want to delete this message?"),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00BF6D)),
                                                      ),
                                                    ),
                                                    CupertinoDialogAction(
                                                      onPressed: () async {
                                                        Get.back();
                                                        String dcId =
                                                            docIdList[index];
                                                        await FirebaseCloudServices
                                                            .firebaseCloudServices
                                                            .deleteChatReceiver(
                                                                getX.receiverEmail
                                                                    .value,
                                                                true,
                                                                dcId);
                                                      },
                                                      child: const Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00BF6D)),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          isDestructiveAction: true,
                                          trailingIcon: CupertinoIcons.delete,
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                      child: MessageWidget(
                                        message: chatList[index],
                                        img: widget.img,
                                        index: index,
                                        docIdList: docIdList[index],
                                      ),
                                    )
                          : (chatList[index].delete == true &&
                                  chatList[index].deleteSender)
                              ? Container()
                              : (chatList[index].delete == true)
                                  ? CupertinoContextMenu(
                                      actions: <Widget>[
                                        CupertinoContextMenuAction(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the context menu
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: const Text(
                                                      "Delete Confirmation"),
                                                  content: const Text(
                                                      "Are you sure you want to delete this message?"),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00BF6D)),
                                                      ),
                                                    ),
                                                    CupertinoDialogAction(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop(); // Close the alert dialog
                                                        String dcId =
                                                            docIdList[index];
                                                        await FirebaseCloudServices
                                                            .firebaseCloudServices
                                                            .deleteChatSenderMe(
                                                          getX.receiverEmail
                                                              .value,
                                                          true,
                                                          dcId,
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00BF6D)),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          isDestructiveAction: true,
                                          trailingIcon: CupertinoIcons.delete,
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                      child: MessageWidgetReceiver(
                                        message: chatList[index],
                                        img: widget.img,
                                      ),
                                    )
                                  : (chatList[index].deleteSender == true)
                                      ? Container()
                                      : CupertinoContextMenu(
                                          actions: <Widget>[
                                            CupertinoContextMenuAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              isDefaultAction: true,
                                              trailingIcon: CupertinoIcons
                                                  .doc_on_clipboard_fill,
                                              child: const Text('Copy'),
                                            ),
                                            CupertinoContextMenuAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              trailingIcon:
                                                  CupertinoIcons.share,
                                              child: const Text('Share'),
                                            ),
                                            CupertinoContextMenuAction(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                showCupertinoDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    TextEditingController
                                                        textUpdate =
                                                        TextEditingController(
                                                      text: chatList[index]
                                                          .message,
                                                    );
                                                    return CupertinoAlertDialog(
                                                      title: const Text(
                                                          "Update Confirmation"),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      5),
                                                          child: Column(
                                                            children: [
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    TextFormField(
                                                                  cursorColor:
                                                                      const Color(
                                                                          0xFF00BF6D),
                                                                  // maxLines: 3,
                                                                  controller:
                                                                      textUpdate,
                                                                  style: GoogleFonts.lato(
                                                                      textStyle: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .onPrimary)),
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  decoration: InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      fillColor: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onSecondary,
                                                                      hintStyle:
                                                                          GoogleFonts
                                                                              .lato()),
                                                                  onTapOutside: (event) => FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode()),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF00BF6D)),
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () async {
                                                            Get.back();
                                                            // Confirmation for updating the text
                                                            String dcId =
                                                                docIdList[
                                                                    index];
                                                            await FirebaseCloudServices
                                                                .firebaseCloudServices
                                                                .updateChat(
                                                              getX.receiverEmail
                                                                  .value,
                                                              textUpdate.text,
                                                              dcId,
                                                            );
                                                          },
                                                          child: const Text(
                                                            "Confirm",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF00BF6D)),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              trailingIcon: CupertinoIcons.pen,
                                              child: const Text('Edit'),
                                            ),
                                            CupertinoContextMenuAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showCupertinoDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      title: const Text(
                                                        "Delete Confirmation",
                                                      ),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () async {
                                                            Get.back();
                                                            String dcId =
                                                                docIdList[
                                                                    index];
                                                            await FirebaseCloudServices
                                                                .firebaseCloudServices
                                                                .deleteChatSenderAlso(
                                                                    getX.receiverEmail
                                                                        .value,
                                                                    true,
                                                                    dcId);
                                                          },
                                                          child: const Text(
                                                            "Delete For Everyone",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF00BF6D)),
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () async {
                                                            Get.back();
                                                            String dcId =
                                                                docIdList[
                                                                    index];
                                                            await FirebaseCloudServices
                                                                .firebaseCloudServices
                                                                .deleteChatSenderMe(
                                                                    getX.receiverEmail
                                                                        .value,
                                                                    true,
                                                                    dcId);
                                                          },
                                                          child: const Text(
                                                            "Delete For Me",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF00BF6D)),
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () async {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                            "Close",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF00BF6D)),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              isDestructiveAction: true,
                                              trailingIcon:
                                                  CupertinoIcons.delete,
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                          child: MessageWidget(
                                            message: chatList[index],
                                            img: widget.img,
                                            index: index,
                                            docIdList: docIdList[index],
                                          ),
                                        );
                    },
                  );
                },
              ),
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  // bool _showAttachment = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0 / 2,
      ),
      // margin: EdgeInsets.only(top: 10),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).scaffoldBackgroundColor,
      //   boxShadow: [
      //     BoxShadow(
      //       offset: const Offset(0, -4),
      //       blurRadius: 32,
      //       color: const Color(0xFF087949).withOpacity(0.08),
      //     ),
      //   ],
      // ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 16.0 / 4),
                      Expanded(
                        child: TextField(
                          controller: getX.txtMassage,
                          onChanged: (value) {
                            FirebaseCloudServices.firebaseCloudServices
                                .toggleOnlineStatus(
                              true,
                              Timestamp.now(),
                              true,
                            );
                          },
                          onTapOutside: (event) {
                            FirebaseCloudServices.firebaseCloudServices
                                .toggleOnlineStatus(
                              true,
                              Timestamp.now(),
                              false,
                            );
                          },
                          onTap: () => scrollToBottom(),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Type message",
                            suffixIcon: SizedBox(
                              width: 88,
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.attach_file,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.64),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0 / 2),
                                    child: IconButton(
                                      onPressed: () async {
                                        ImagePicker imagePicker = ImagePicker();
                                        XFile? xFileImage =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        File image = File(xFileImage!.path);
                                        ChatModel chat = ChatModel(
                                            massageType: MassageType.image,
                                            readAndUnReadMassage: false,
                                            sender: SimpleAuth.simpleAuth
                                                .getCurrentUser()!
                                                .email!,
                                            receiver: getX.receiverEmail.value,
                                            message:
                                                await CloudStorageFirebaseSaveAnyFiles
                                                    .cloudStorageFirebaseSaveAnyFiles
                                                    .imageStorageIntoChatSander(
                                                        image),
                                            editTime: Timestamp.now(),
                                            edit: false,
                                            delete: false,
                                            deleteSender: false,
                                            time: Timestamp.now(),
                                            deleteReceiver: false);
                                        await FirebaseCloudServices
                                            .firebaseCloudServices
                                            .addChatFireStore(chat);
                                      },
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.64),
                                      icon: Icon(Icons.camera_alt_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            filled: true,
                            fillColor:
                                const Color(0xFF00BF6D).withOpacity(0.08),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                IconButton(
                    onPressed: () async {
                      if (getX.txtMassage.text.trim().isNotEmpty) {
                        ChatModel chat = ChatModel(
                          sender: SimpleAuth.simpleAuth.getCurrentUser()!.email,
                          receiver: getX.receiverEmail.value,
                          message: getX.txtMassage.text,
                          time: Timestamp.now(),
                          editTime: Timestamp.now(),
                          edit: false,
                          delete: false,
                          deleteSender: false,
                          deleteReceiver: false,
                          massageType: MassageType.massage,
                          readAndUnReadMassage: false,
                        );
                        getX.txtMassage.clear();
                        await FirebaseCloudServices.firebaseCloudServices
                            .addChatFireStore(chat);
                        await FirebaseCloudServices.firebaseCloudServices
                            .lastMessageStore(
                          getX.receiverEmail.value,
                          getX.txtMassage.text,
                          Timestamp.now(),
                        )
                            .then((_) {
                          scrollToBottom();
                        });
                        // Clear the text field after sending the message
                      }
                    },
                    icon: const Icon(Icons.send)),
              ],
            ),
            // if (_showAttachment) const MessageAttachment(),
          ],
        ),
      ),
    );
  }
}

class MessageAttachment extends StatelessWidget {
  const MessageAttachment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MessageAttachmentCard(
            iconData: Icons.insert_drive_file,
            title: "Document",
            press: () {},
          ),
          MessageAttachmentCard(
            iconData: Icons.image,
            title: "Gallary",
            press: () {},
          ),
          MessageAttachmentCard(
            iconData: Icons.headset,
            title: "Audio",
            press: () {},
          ),
          MessageAttachmentCard(
            iconData: Icons.videocam,
            title: "Video",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class MessageAttachmentCard extends StatelessWidget {
  final VoidCallback press;
  final IconData iconData;
  final String title;

  const MessageAttachmentCard(
      {super.key,
      required this.press,
      required this.iconData,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(16.0 / 2),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0 * 0.75),
              decoration: const BoxDecoration(
                color: Color(0xFF00BF6D),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 20,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(height: 16.0 / 2),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.8),
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            const CircleAvatar(
              radius: 12,
              backgroundImage:
                  NetworkImage("https://i.postimg.cc/cCsYDjvj/user-2.png"),
            ),
            const SizedBox(width: 16.0 / 2),
          ],
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0 * 0.75,
              vertical: 16.0 / 2,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF00BF6D)
                  .withOpacity(message.isSender ? 1 : 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isSender
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class VideoMessage extends StatelessWidget {
  const VideoMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                  "https://i.postimg.cc/Ls1WtygL/Video-Place-Here.png"),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                color: Color(0xFF00BF6D),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  final ChatMessage? message;

  const AudioMessage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0 * 0.75,
        vertical: 16.0 / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF00BF6D).withOpacity(message!.isSender ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message!.isSender ? Colors.white : const Color(0xFF00BF6D),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0 / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message!.isSender
                        ? Colors.white
                        : const Color(0xFF00BF6D).withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message!.isSender
                            ? Colors.white
                            : const Color(0xFF00BF6D),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12, color: message!.isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    this.message,
  });

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0 * 0.75,
        vertical: 16.0 / 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF00BF6D).withOpacity(message!.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.notSent:
          return const Color(0xFFF03738);
        case MessageStatus.notView:
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return const Color(0xFF00BF6D);
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: 16.0 / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.notSent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

enum ChatMessageType { text, audio, image, video }

enum MessageStatus { notSent, notView, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}
