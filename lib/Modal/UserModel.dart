import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name, email, image, phone, token, aboutUs;
  late bool isOnline, isTyping;
  late Timestamp timestamp;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.token,
    required this.aboutUs,
    this.isOnline = false,
    this.isTyping = false,
    required this.timestamp,
  });

  // Factory constructor to create UserModel from a Map
  factory UserModel.fromUser(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? 'Unknown', // Fallback value for null
      email: data['email'] ?? 'No Email',
      image: data['image'] ?? 'default_image_url', // Fallback URL for image
      phone: data['phone'] ?? 'No Phone',
      token: data['token'] ?? '', // If no token, empty string
      aboutUs: data['aboutUs'] ?? '', // If no last message, empty string
      isOnline: data['isOnline'] ?? false, // Default is offline
      isTyping: data['isTyping'] ?? false, // Default is not typing
      timestamp: data['timestamp'] ?? Timestamp.now(), // Default is current time
    );
  }

  // Method to convert UserModel to a Map
  Map<String, dynamic> toMap(UserModel user) {
    return {
      'email': user.email,
      'name': user.name,
      'image': user.image,
      'token': user.token,
      'phone': user.phone,
      'aboutUs': user.aboutUs,
      'isOnline': user.isOnline,
      'isTyping': user.isTyping,
      'timestamp': user.timestamp,
    };
  }
}
