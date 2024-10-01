import 'package:chat_app/Screens/AuthScreen/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../FireBase/AuthServices/GoogleAuth.dart';
import '../../../FireBase/AuthServices/SimpleAuth.dart';
import '../../../FireBase/FireStore/UserStore.dart';
import '../../../Modal/ChatModel.dart';
import '../../../Modal/UserModel.dart';
import '../../../Utils/Global.dart';
import '../../ChatScreen/View/ChartPage.dart';
import '../../ContactsScreen/View/ContactsScreen.dart';
import '../../ProfileScreen/View/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseCloudServices.firebaseCloudServices.toggleOnlineStatus(
      true,
      Timestamp.now(),
      false,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      FirebaseCloudServices.firebaseCloudServices.toggleOnlineStatus(
        false,
        Timestamp.now(),
        false,
      );
    } else if (state == AppLifecycleState.resumed) {
      FirebaseCloudServices.firebaseCloudServices.toggleOnlineStatus(
        true,
        Timestamp.now(),
        false,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
               FirebaseCloudServices.firebaseCloudServices.toggleOnlineStatus(
                false,
                Timestamp.now(),
                false,
              );
              await SimpleAuth.simpleAuth.signOut();
              await GoogleAuthService.googleAuthService.signOutFromGoogle();

              Get.offAll(LoginPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Get.to(ProfileScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseCloudServices.firebaseCloudServices
                  .readAllUserFromFireStore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No users found.'),
                  );
                }

                List data = snapshot.data!.docs;
                userModal = [];
                for (var user in data) {
                  userModal.add(UserModel.fromUser(user.data()));
                }

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      userModal.length,
                      (index) {
                        Timestamp userTimestamp = userModal[index].timestamp;
                        DateTime dateTime = userTimestamp.toDate();
                        String nightDay = dateTime.hour >= 12 ? 'PM' : 'AM';
                        String formattedTime =
                            "${dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')} $nightDay";

                        return InkWell(
                          onTap: () {
                            getX.getReceiver(userModal[index].email,
                                userModal[index].name, userModal[index].image);
                            Get.to(MessagesScreen(
                              email: userModal[index].email,
                              name: userModal[index].name,
                              img: userModal[index].image,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0 * 0.75),
                            child: Row(
                              children: [
                                CircleAvatarWithActiveIndicator(
                                  image: userModal[index].image,
                                  isActive: userModal[index].isOnline,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userModal[index]
                                              .name
                                              .capitalizeFirst!
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(height: 5),
                                        Opacity(
                                          opacity: 0.64,
                                          child: StreamBuilder(
                                            stream: FirebaseCloudServices
                                                .firebaseCloudServices
                                                .getLastChatFromFireStore(
                                                    userModal[index].email),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic>
                                                    snapshot) {
                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty)
                                                return Text(
                                                  userModal[index].aboutUs,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .inversePrimary,
                                                    fontFamily: 'pr',
                                                    fontSize: width * 0.037,
                                                  ),
                                                );

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting)
                                                return const Text('');

                                              Map data =
                                                  snapshot.data!.docs[0].data();
                                              //todo ------------------------------> return last message
                                              if (!data["message"]
                                                  .startsWith('http')) {
                                                return Container(
                                                  width: width * 0.545,
                                                  margin:
                                                      const EdgeInsets.only(right: 5),
                                                  child: Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    data["message"],
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                      fontFamily:
                                                          'pr', // fontSize: width * 0.0375
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Row(
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      " Image",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .inversePrimary,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Opacity(
                                      opacity: 0.64,
                                      child: Text(formattedTime,style: const TextStyle(fontSize: 12),),
                                    ),
                                    const SizedBox(height: 2,),
                                    StreamBuilder(
                                        stream: FirebaseCloudServices.firebaseCloudServices.readChatFromFireStore(userModal[index].email),
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
                                          int value=0;
                                          for(int i =0 ; i<chatList.length;i++)
                                          {
                                            if(chatList[i].readAndUnReadMassage==false && chatList[i].sender!=SimpleAuth.simpleAuth.getCurrentUser()!.email)
                                            {
                                              value++;
                                            }
                                          }

                                          return (value!=0)?Container(
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(value.toString(),style: const TextStyle(color: Colors.white),),
                                            ),):const Spacer();
                                        }
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to ContactsScreen
        },
        backgroundColor: const Color(0xFF00BF6D),
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }
}


class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    super.key,
    this.isFilled = true,
    required this.press,
    required this.text,
  });

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 2 : 0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? const Color(0xFF1D1D35) : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    this.image,
    this.radius = 24,
    this.isActive,
  });

  final String? image;
  final double? radius;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: image!.startsWith('http')
              ? NetworkImage(image!) // For network images
              : AssetImage(image!) as ImageProvider, // For local assets
          backgroundColor: Colors
              .grey[200], // Add a background color in case image is not found
        ),
        if (isActive!)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          )
      ],
    );
  }
}
