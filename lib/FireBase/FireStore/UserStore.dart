import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Modal/ChatModel.dart';
import '../../Modal/UserModel.dart';
import '../AuthServices/SimpleAuth.dart';

class FirebaseCloudServices {
  FirebaseCloudServices._();

  static FirebaseCloudServices firebaseCloudServices =
  FirebaseCloudServices._();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel userModal) async {
    await firebaseFireStore.collection("users").doc(userModal.email).set({
      "email": userModal.email,
      // "phoneNo": userModal.phoneNo,
      "image": userModal.image,
      "name": userModal.name,
      "token": userModal.token,
      'aboutUs' : userModal.aboutUs,
      'isOnline': false,
      'isTyping': false,
      'timestamp': Timestamp.now(),
    });
  }

  // -----------------------------------------------------------------
  Future<void> toggleOnlineStatus(
      bool status, Timestamp timestamp, bool isTyping) async {
    String email = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    await firebaseFireStore.collection("users").doc(email).update({
      'isOnline': status,
      'timestamp': timestamp,
      'isTyping': isTyping,
    });
  }

  Future<void> lastMessageStore(
      String email,String message, Timestamp timestamp) async {
    // String email = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    await firebaseFireStore.collection("users").doc(email).update({
      'lastMessage': message,
      'timestamp':timestamp
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIsOnlineOrNot(
      String email) {
    return firebaseFireStore.collection("users").doc(email).snapshots();
  }

  //todo read Current user data
  Future<DocumentSnapshot<Map<String, dynamic>>>
  readCurrentUserIntoFireStore() async {
    User? user = SimpleAuth.simpleAuth.getCurrentUser();
    return await firebaseFireStore.collection('users').doc(user!.email).get();
  }

  //todo read all user data
  Stream<QuerySnapshot<Map<String, dynamic>>> readAllUserFromFireStore() {
    User? user = SimpleAuth.simpleAuth.getCurrentUser();
    return firebaseFireStore
        .collection("users")
            // .orderBy("timestamp", descending: false)
        .where("email", isNotEqualTo: user!.email)
        .snapshots(); // Returns a real-time stream
  }


  //todo chat in fire store
  Future<void> addChatFireStore(ChatModel chat)
  async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await firebaseFireStore.collection("chatroom").doc(docId).collection("chat").add(chat.toMap(chat));
  }

// todo chat read and and receiver
  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(String receiver)
  {
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender,receiver];
    doc.sort();
    String docId = doc.join("_");
    return firebaseFireStore.collection("chatroom").doc(docId).collection("chat").orderBy('time',descending: false).snapshots();
  }

  //-----------------------------

//Todo UPDATE
  Future<void> updateChat(String receiver, String massage, String dcId) async {
    // ChatModel chat ;//update
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await firebaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({
      "message": massage,
      "edit": true,
      "editTime": Timestamp.now(),
    });
  }

  //Todo DELETE ME
  Future<void> deleteChatSenderMe(
      String receiver, bool delete, String dcId) async {
    // ChatModel chat ;//update
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await firebaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({
      "editTime": Timestamp.now(),
      // "delete" : true,//delete all
      "deleteSender": true,
    });
  }

  //Todo DELETE Also
  Future<void> deleteChatSenderAlso(
      String receiver, bool delete, String dcId) async {
    // ChatModel chat ;//update
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await firebaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({
      "editTime": Timestamp.now(),
      "delete": true, //delete all
    });
  }

  //Todo DELETE Receiver
  Future<void> deleteChatReceiver(
      String receiver, bool delete, String dcId) async {
    // ChatModel chat ;//update
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await firebaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({
      "editTime": Timestamp.now(),
      "deleteReceiver": delete, //delete Receiver
    });
  }

  //todo user msg read and unread massage
  Future<void> userReadAndUnRead(
      String receiver, bool readAndUnReadMassage, String dcId) async {
    // ChatModel chat ;//update
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await firebaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({
      'readAndUnReadMassage': readAndUnReadMassage,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastChatFromFireStore(String receiver) {
    String sender = SimpleAuth.simpleAuth.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    return firebaseFireStore.collection("chatroom").doc(docId).collection("chat").orderBy("time", descending: true).limit(1).snapshots();
  }
}