import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../FireBase/FireStore/UserStore.dart';
import '../../../Modal/UserModel.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseCloudServices.firebaseCloudServices.readCurrentUserIntoFireStore(),
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
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                child: Text('No data available'),
              );
            }
            Map<String, dynamic>? data = snapshot.data!.data();
            UserModel userModal = UserModel.fromUser(data!);

            return Column(
              children: [
                ProfilePic(image: userModal.image ?? ''), // Pass the profile image URL
                Text(
                  userModal.name.capitalizeFirst!.toString(),

                ),
                const Divider(height: 32.0),
                Info(
                  infoKey: "User ID",
                  info: "@${userModal.name}",
                ),
                Info(
                  infoKey: "Location",
                  info:  'Unknown',
                ),
                Info(
                  infoKey: "Phone",
                  info: userModal.phone ?? 'N/A',
                ),
                Info(
                  infoKey: "Email Address",
                  info: userModal.email ?? 'N/A',
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BF6D),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Get.to(EditProfileScreen());
                      },
                      child: const Text("Edit profile"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )

    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: image!.startsWith('http')
                ? NetworkImage(image!) // For network images
                : AssetImage(image!) as ImageProvider, // For local assets
            backgroundColor: Colors.grey[200],
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
